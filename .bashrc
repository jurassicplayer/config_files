#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom bash prompt
PS1='[\@ \W]\$> '

# Reload .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# Start mpd
[ ! -s ~/.config/mpd/pid ] && mpd

# colorized aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# pacman aliases
alias pacorphan="pacaur -Qtdq > /dev/null && pacaur -Rns \$(pacaur -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')"
alias pacpkg="pacaur -Qe"
alias paccache="pacaur -Sc"

# Functions
stream() {
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
            break
            ;;
    esac
    pacmd load-module module-null-sink sink_name=duplex_out
    pacmd load-module module-null-sink sink_name=game_out
    pacmd load-module module-loopback source=game_out.monitor
    pacmd load-module module-loopback source=game_out.monitor sink=duplex_out
    pacmd load-module module-loopback sink=duplex_out
    ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0+${POS} -f alsa -i pulse \
    -f flv -ac 2 -ar $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN \
    -b:v $CBR -minrate $CBR -maxrate $CBR -profile:v $PROFILE \
    -level $PROFILE_LEVEL -pix_fmt yuv420p -s $OUTRES -tune zerolatency \
    -acodec $AUDIO_CODEC -threads $THREADS -strict experimental -bufsize $CBR \
    "${SERVER}" >/dev/null 2>&1
    pacmd unload-module module-loopback
    pacmd unload-module module-null-sink
 }
