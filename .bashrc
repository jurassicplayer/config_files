#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom bash prompt
PS1='[\@ \W]\$> '

# Fim font
export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz

# Reload .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# colorized aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# pacman aliases
alias pacorphan='pacaur -Rns $(pacaur -Qtdq)'
alias pacpkg='pacaur -Qe >> packagelist.txt ; pacaur -Qe'
alias paccache='pacaur -Sc'
alias pacreflect='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'

# dmenu configuration
alias dmenu_run='dmenu_run -fn "Terminess Powerline-9" -dim 0.5 -nb "#262626" -nf "#cccccc" -sb "#005f87" -sf "#ffffff"'

# Streaming script
alias stream='~/.config/openbox/scripts/stream.sh stream'

# Misc
alias steam_clean='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete; find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete'
