#!/bin/bash

if [[ $1 == 'start' ]]; then
    crd --start &
    tmux new-session -s ngrok -d ngrok tcp 22 --log false &
elif [[ $1 == 'ngrok' ]]; then
    tmux new-session -s ngrok -d ngrok tcp 22 --log false &
elif [[ $1 == 'crd' ]]; then
    crd --start &
elif [[ $1 == 'stop' ]]; then
    crd --stop &
    tmux kill-session -t ngrok &
fi
