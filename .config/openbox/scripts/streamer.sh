#!/bin/bash

stream_setup() {
    INRES="1366x768" # input resolution
    OUTRES="1366x768" # output resolution
    POS="0,0" # top-left corner of capture window
    FPS="15" # target FPS
    GOP="30" # i-frame interval, should be double of FPS, 
    GOPMIN="15" # min i-frame interval, should be equal to fps, 
    THREADS="2" # max 6
    CBR="1200k" # constant bitrate (should be between 1000k - 3000k)
    #QUALITY="ultrafast"  # one of the many FFMPEG preset
    AUDIO_CODEC="libmp3lame"
    AUDIO_RATE="44100"
    PROFILE="baseline"
    PROFILE_LEVEL="3.2"
    TWITCH_SRV="live-lax" # twitch server
    TWITCH_RTMP="rtmp://${TWITCH_SRV}.twitch.tv/app/${TWITCH_KEY}"
    HITBOX_RTMP="rtmp://live.hitbox.tv/push/${HITBOX_KEY}"
    LIVECODING_RTMP="rtmp://usmedia3.livecoding.tv:1935/livecodingtv/${LIVECODING_KEY}"
     
    case $1 in
        t)
            SERVER=$TWITCH_RTMP
            ;;
        hb)
            SERVER=$HITBOX_RTMP
            FPS="25"
            CBR="2500k"
            GOP="50"
            GOPMIN="25"
            AUDIO_CODEC="aac"
            PROFILE="high"
            PROFILE_LEVEL="4.0"
            ;;
        lc)
            SERVER=$LIVECODING_RTMP
            ;;
        clean)
            pactl unload-module module-loopback
            pactl unload-module module-null-sink
            echo "Cleaned audio interfaces."
            exit
            ;;
        *)
            echo "Invalid streaming service."
            exit
            ;;
    esac
}

audio_setup() {
    ## Set Applications
    GrabInputs "Select recorded applications:" "checklist" "TRUE" "$(pacmd list-sink-inputs | grep -e 'application.name = ' -e 'index: ')"
    APPS=$(echo $RES)
    
    ## Set Microphone
    GrabInputs "Select microphone:" "radiolist" "FALSE" "$(pacmd list-sources | grep -e 'device.description = ' -e 'index:')"
    MICS=$(echo $RES)
    
    ## Setup sinks
    SINK_DUPLEX=$(pactl load-module module-null-sink sink_name="duplex_out" sink_properties=device.description="Duplex")
    SINK_CAUDIO=$(pactl load-module module-null-sink sink_name="caudio_out" sink_properties=device.description="CAudio")
    #echo Sink Duplex: $SINK_DUPLEX
    #echo Sink CAudio: $SINK_CAUDIO
    ## Set default sink to CAudio (new applications use CAudio)
    pactl set-default-sink caudio_out
    pactl set-default-source $(pactl list short sources | grep -e 'duplex_out.monitor' -e 'index' | awk '{print $1;}')
    #echo Default sink: caudio_out
    if [[ -n $APPS ]]; then
        for index in $(echo $APPS | tr "|" "\n"); do
            #echo Application Index: $APPS
            ## Send application stream to the CAudio sink
            pactl move-sink-input $index caudio_out
        done
    fi
    
    ## Setup loopback for caudio_out
    LOOPBACK_CAUDIO_OUT=$(pactl load-module module-loopback source=caudio_out.monitor sink=0)
    LOOPBACK_CAUDIO_IN=$(pactl load-module module-loopback source=caudio_out.monitor sink=duplex_out)
    #echo Loopback cout: $LOOPBACK_CAUDIO_OUT
    #echo Loopback cin: $LOOPBACK_CAUDIO_IN

    ## Setup loopback for microphone
    if [[ -n $MICS ]]; then
        LOOPBACK_MIC=$(pactl load-module module-loopback source=$MICS sink=duplex_out)
        #echo Loopback mic: "$LOOPBACK_MIC"
    fi
}

ffmpeg_stream() {
    ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0+${POS} -f alsa -i pulse \
    -f flv -ac 2 -ar $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN \
    -b:v $CBR -minrate $CBR -maxrate $CBR -profile:v $PROFILE \
    -level $PROFILE_LEVEL -pix_fmt yuv420p -s $OUTRES -tune zerolatency \
    -acodec $AUDIO_CODEC -threads $THREADS -strict experimental -bufsize $CBR \
    "${SERVER}" >/dev/null 2>&1 
}

audio_cleanup() {
    #echo Unload: CAudio Out
    pactl unload-module "$LOOPBACK_CAUDIO_OUT"
    #echo Unload: CAudio In
    pactl unload-module "$LOOPBACK_CAUDIO_IN"
    if [[ -n $LOOPBACK_MIC ]]; then
        echo Unload: Mic
        pactl unload-module $LOOPBACK_MIC
    fi
    #echo Unload: Sink duplex
    pactl unload-module $SINK_DUPLEX
    #echo Unload: Sink caudio
    pactl unload-module $SINK_CAUDIO
}

GrabInputs() {
    local IFS=$'\n'
    local APP_ARRAY=()
    local APP_LIST="$4"
    local DEFAULT_VALUE="$3"
    local TEXT="$1"
    local LIST_TYPE="$2"
    for entry in $APP_LIST; do
        app=""
        case "$entry" in 
            *index*)
                index=$(echo $entry | grep -o '[0-9][0-9]*')
                ;;
            *device.description*)
                ;&
            *application.name*)
                app=$(echo $entry | grep -o '"[^"]\+"' | tr -d '"')
                ;;
        esac
        if [[ -n $app ]]; then
            APP_ARRAY=("${APP_ARRAY[@]}" "$DEFAULT_VALUE" "$index" "$app")
        fi
    done
    
    # zenity selector
    RES=$(zenity \
        --list \
        --$LIST_TYPE \
        --title="Select Audio Stream" \
        --text="$TEXT" \
        --column '' --column 'Index' --column 'Audio Stream' \
        "${APP_ARRAY[@]}" 2>/dev/null )
}

stream_setup $1
audio_setup
if [[ -n $APPS ]] || [[ -n $MICS ]]; then
    ffmpeg_stream
else
    echo "Stream was cancelled."
fi
audio_cleanup
