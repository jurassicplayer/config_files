#!/bin/bash

DIR=`dirname "$0"`
TOGGLE=$DIR/stream_muted
BRBSCRN=$DIR/brb_screen.png

if [ ! -e $TOGGLE ];then
    case $1 in
        brb)
            notify-send "BRB" "Processing life, back in a moment..."
            (feh -xF --hide-pointer $BRBSCRN)&
            echo $! > $TOGGLE
            (sleep 60 && notify-send "BRB" "Killing stream in 4 min(s)" && sleep 60 && notify-send "BRB" "Killing stream in 3 min(s)" && sleep 60 && notify-send "BRB" "Killing stream in 2 min(s)" && sleep 60 && notify-send "BRB" "Killing stream in 1 min" && sleep 45 && notify-send "BRB" "Sorry I couldn't make it back." && sleep 15 && pkill -SIGINT ffmpeg && (exec $0))&
            echo $! >> $TOGGLE
            ;;
        *)
            notify-send --urgency low "Mic Status" "Muted"
            touch $TOGGLE
            ;;
    esac
    pacmd set-source-mute "alsa_input.usb-Samson_Technologies_Samson_GoMic-00.analog-mono" 1
else
    if [ -s $TOGGLE ]; then
        notify-send "BRB" "...and we're back."
        for i in $(cat $TOGGLE)
        do
            kill -kill $i
        done
    else
        notify-send --urgency low "Mic Status" "Unmuted"
    fi
    #case $1 in
        #brb)
            #notify-send "BRB" "...and we're back."
            #for i in $(cat $TOGGLE)
            #do
                #kill -kill $i
            #done
            #;;
        #*)
            #notify-send "Mic Status" "Unmuted"
            #;;
    #esac
    rm $TOGGLE
    pacmd set-source-mute "alsa_input.usb-Samson_Technologies_Samson_GoMic-00.analog-mono" 0
fi
