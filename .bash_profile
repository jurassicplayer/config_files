#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# export environment variables
export EDITOR=vim
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export LIVECODING_KEY=""
export HITBOX_KEY=""
export TWITCH_KEY=""

# Start X session on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
