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
alias pacorphan='pacaur -Qtdq > /dev/null && pacaur -Rns \$(pacaur -Qtdq | sed -e ":a;N;\$!ba;s/\n/ /g")'
alias pacpkg='pacaur -Qe'
alias paccache='pacaur -Sc'

# dmenu configuration
alias dmenu_run='dmenu_run -fn "Terminess Powerline-9" -dim 0.5 -nb "#262626" -nf "#cccccc" -sb "#005f87" -sf "#ffffff"'

# Streaming script
alias stream='~/.config/openbox/scripts/stream.sh stream'
