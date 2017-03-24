#!/bin/bash
exec_file(){
    if [[ $1 ]]; then
        exo-open "$1"
    fi
}
exec_file "$(locate -L -i -e home mnt/Media/Downloads | rofi -threads 0 -dmenu -i -p 'locate:')"
