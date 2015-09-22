#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom bash prompt
PS1='[\@ \W]\$> '

# Reload .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Aliases {{{
# colorized aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# pacman aliases
alias pacorphan="pacaur -Qtdq > /dev/null && pacaur -Rns \$(pacaur -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')"
alias pacpkg="pacaur -Qe"
alias paccache="pacaur -Sc"
# }}} vim:foldmethod=marker:foldlevel=0
