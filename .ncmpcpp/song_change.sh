#!/bin/bash
CURRENT_SONG=$(ncmpcpp --current-song "{{{%a - }%t}}|{%f}" 2>&1 | tail -n1)
notify-send MPD "$CURRENT_SONG"
