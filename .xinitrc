#!/bin/bash

# Reload .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Reload .Xmodmap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

#exec awesome
exec openbox-session
