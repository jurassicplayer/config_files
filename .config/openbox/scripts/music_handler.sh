#!/bin/bash
ps cax | grep rhythmbox > /dev/null
if [ $? -eq 0 ]; then
    PLAYER=rhythmbox
fi
ps cax | grep quodlibet > /dev/null
if [ $? -eq 0 ]; then
    PLAYER=quodlibet
fi
ps cax | grep mpd > /dev/null
if [ $? -eq 0 ]; then
    PLAYER=mpc
fi

case $1 in
    next)
        case $PLAYER in
            quodlibet)
                ;&
            rhythmbox)
                ${PLAYER} --next
                ;&
            mpc)
                mpc next
                ;;
            *)
                echo "No valid player found."
                ;;
        esac
        ;;
    prev)
        case $PLAYER in
            quodlibet)
                ;&
            rhythmbox)
                ${PLAYER} --previous
                ;&
            mpc)
                mpc prev
                ;;
            *)
                echo "No valid player found."
                ;;
        esac
        ;;
    toggle)
        case $PLAYER in
            quodlibet)
                ;&
            rhythmbox)
                ${PLAYER} --play-pause
                ;&
            mpc)
                mpc toggle
                ;;
            *)
                echo "No valid player found."
                ;;
        esac
        ;;
    *)
        echo "Invalid command"
        ;;
esac
