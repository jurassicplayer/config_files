#!/bin/bash

# Reload .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#exec awesome
exec openbox-session
