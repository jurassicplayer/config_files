#!/bin/bash

stream_setup() {
    echo "Setup stream"
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
        *)
            echo "Invalid streaming service."
            exit
            ;;
    esac
}
ffmpeg_stream() {
    echo "Started FFMpeg stream"
    ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0+${POS} -f alsa -i pulse \
    -f flv -ac 2 -ar $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN \
    -b:v $CBR -minrate $CBR -maxrate $CBR -profile:v $PROFILE \
    -level $PROFILE_LEVEL -pix_fmt yuv420p -s $OUTRES -tune zerolatency \
    -acodec $AUDIO_CODEC -threads $THREADS -strict experimental -bufsize $CBR \
    "${SERVER}" >`dirname $0`/ffmpeg_stream.log 2>&1
    notify-send --urgency critical "FFMpeg" "Stream has ended."
}

audio_setup() {
    echo "Setup audio"
    ## Set Applications
    grab_inputs "list-sink-inputs" "application.name"
    zenity_window "checklist" "Select recorded applications:" "TRUE"
    APPS=$(echo $RESULT)
    
    ## Set Microphone
    grab_inputs "list-sources" "device.description"
    zenity_window "checklist" "Select microphone:" "FALSE"
    MICS=$(echo $RESULT)
    
    ## Setup sinks
    SINK_DUPLEX=$(pactl load-module module-null-sink sink_name="duplex_out" sink_properties=device.description="Duplex")
    SINK_CAUDIO=$(pactl load-module module-null-sink sink_name="caudio_out" sink_properties=device.description="CAudio")
    ## Set default sink to CAudio (new applications use CAudio)
    pactl set-default-sink caudio_out
    pactl set-default-source $(pactl list short sources | grep -e 'duplex_out.monitor' -e 'index' | awk '{print $1;}')
    if [[ -n $APPS ]]; then
        for index in $(echo $APPS | tr "|" "\n"); do
            ## Send application stream to the CAudio sink
            pactl move-sink-input $index caudio_out
        done
    fi
    
    ## Setup loopback for caudio_out
    LOOPBACK_CAUDIO_OUT=$(pactl load-module module-loopback source=caudio_out.monitor sink=0)
    LOOPBACK_CAUDIO_IN=$(pactl load-module module-loopback source=caudio_out.monitor sink=duplex_out)

    ## Setup loopback for microphone
    if [[ -n $MICS ]]; then
        LOOPBACK_MIC=''
        for index in $(echo $MICS | tr "|" "\n"); do
            LOOPBACK_MIC+=$(pactl load-module module-loopback source=$index sink=duplex_out)
        done
    fi
}

audio_toggle_mute() {
    echo "Toggle audio"
    local dir=`dirname "$0"`
    local toggle=$dir/stream_muted
    local brbscrn=$dir/brb_screen.png
    if [ ! -e $toggle ];then
        case $1 in
            brb)
                notify-send "DUNST_COMMAND_PAUSE"
                ((echo "# Auto-kill Live Stream: 5 min(s)" && echo "0" && \
                    sleep 0.2 && wmctrl -a Brb, Processing Life... -e 0,-1,60,-1,-1 && wmctrl -R Brb, Processing Life... -b add,above && \
                    sleep 60 && echo "# Auto-kill Live Stream: 4 min(s)" && echo "20" && \
                    sleep 60 && echo "# Auto-kill Live Stream: 3 min(s)" && echo "40" && \
                    sleep 60 && echo "# Auto-kill Live Stream: 2 min(s)" && echo "60" && \
                    sleep 60 && echo "# Auto-kill Live Stream: 1 min(s)" && echo "80" && \
                    sleep 40 && echo "# Auto-kill Live Stream: 20 sec(s) Sorry I couldn't make it back." && echo "92" && \
                    sleep 20 && echo "100" && pkill -SIGINT sleep && (exec $0 audio)) | zenity --progress \
                    --title="Brb, Processing Life..." \
                    --text="Automatic-Kill Live Stream (5min)" \
                    --percentage=0 \
                    --auto-close \
                    --no-cancel >/dev/null 2>&1 )&
                echo $! > $toggle
                (feh -x --hide-pointer $brbscrn)&
                echo $! >> $toggle
                ;;
            *)
                notify-send --urgency low "Mic Status" "Muted"
                touch $toggle
                ;;
        esac
        grab_inputs "list-sources" "device.class"
        for entry in ${INPUT_ARRAY[@]}; do
            pacmd set-source-mute $entry 1
        done
    else
        if [ -s $toggle ]; then
            notify-send "BRB" "...and we're back."
            notify-send "DUNST_COMMAND_RESUME"
            for i in $(cat $toggle); do
                pkill -TERM -P $i
                kill -kill $i
            done
        else
            notify-send --urgency low "Mic Status" "Unmuted"
        fi
        rm $toggle
        grab_inputs "list-sources" "device.class"
        for entry in ${INPUT_ARRAY[@]}; do
            pacmd set-source-mute $entry 0
        done
    fi
}

audio_cleanup() {
    echo "Cleanup audio"
    if [[ -n $LOOPBACK_CAUDIO_OUT ]] || [[ -n $LOOPBACK_CAUDIO_IN ]] || [[ -n $LOOPBACK_MIC ]] || [[ -n $SINK_DUPLEX ]] || [[ -n $SINK_CAUDIO ]]; then
        if [[ -n $LOOPBACK_CAUDIO_OUT ]]; then 
            pactl unload-module "$LOOPBACK_CAUDIO_OUT"
        fi
        if [[ -n $LOOPBACK_CAUDIO_IN ]]; then
            pactl unload-module "$LOOPBACK_CAUDIO_IN"
        fi
        if [[ -n $LOOPBACK_MIC ]]; then
            for index in ${LOOPBACK_MIC[@]}; do
                pactl unload-module $index
            done
        fi
        if [[ -n $SINK_DUPLEX ]]; then
            pactl unload-module $SINK_DUPLEX
        fi
        if [[ -n $SINK_CAUDIO ]]; then
            pactl unload-module $SINK_CAUDIO
        fi
    else
        pacmd unload-module module-loopback
        pacmd unload-module module-null-sink
    fi
}

grab_inputs() {
    local IFS=$'\n'
    local cmd=$1
    local match_tag=$2
    local input_list=$(pacmd "$cmd" | grep -e "$match_tag" -e 'index')
    INPUT_ARRAY=()
    for entry in $input_list; do
        local input=""
        case "$entry" in
            *index*)
                index=$(echo $entry | grep -o '[0-9][0-9]*')
                ;;
            *"$match_tag"*)
                input=$(echo $entry | grep -o '"[^"]\+"' | tr -d '"')
                ;;
        esac
        if [[ -n $input ]]; then
            case "$match_tag" in
                application.name)
                    INPUT_ARRAY=("${INPUT_ARRAY[@]}" "TRUE" "$index" "$input")
                    ;;
                device.description)
                    if [[ -z $(echo $input | grep -o 'Monitor') ]]; then
                        INPUT_ARRAY=("${INPUT_ARRAY[@]}" "FALSE" "$index" "$input")
                    fi
                    ;;
                device.class)
                    if [[ -z $(echo $input | grep -o 'monitor') ]]; then
                        INPUT_ARRAY=("${INPUT_ARRAY[@]}" "$index")
                    fi
                    ;;
            esac
        fi
    done
}
zenity_window() {
    local IFS=$'\n'
    local list_type=$1
    local text=$2
    local zenity_list=("${INPUT_ARRAY[@]}")
    (sleep 0.3 && wmctrl -R "Select Audio Stream" -b add,above)&
    RESULT=$(zenity \
        --list \
        --$list_type \
        --title="Select Audio Stream" \
        --text="$text" \
        --column '' --column 'Index' --column 'Audio Stream' \
        "${zenity_list[@]}" 2>/dev/null )
    if [[ $? == 1 ]]; then
        echo "Stream was cancelled."
        exit
    fi
}

stream() {
    stream_setup $1
    audio_setup
    if [[ -n $APPS ]] || [[ -n $MICS ]]; then
        ffmpeg_stream
    else
        echo "Stream was cancelled."
        exit
    fi
    audio_cleanup
}

if [[ $1 == 'radio' ]]; then
    echo "radio"
    audio_setup
elif [[ $1 == 'clean' ]]; then
    audio_cleanup
elif [[ $1 == 'audio' ]]; then
    audio_toggle_mute $2
else
    stream $1
fi

