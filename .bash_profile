#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# export environment variables
export EDITOR=vim
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
