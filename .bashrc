#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom bash prompt
PS1='[\@ \W]\$> '

# Add undistract-me
source /usr/share/undistract-me/long-running.bash;notify_when_long_running_commands_finish_install

# Environment variables
# Fim font
export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz
export EDITOR=vim
# Live streaming keys
source ~/.config/stream_keys

# colorized aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# pacman aliases
alias pacorphan='pacaur -Rns $(pacaur -Qtdq)'
alias pacpkg='pacaur -Qe >> packagelist.txt ; pacaur -Qe'
alias paccache='pacaur -Sc'
alias pacreflect='sudo reflector --verbose --country "United States" -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'

# dmenu configuration
#alias dmenu_run='dmenu_run -fn "Terminess Powerline-9" -dim 0.5 -nb "#262626" -nf "#cccccc" -sb "#005f87" -sf "#ffffff"'

# Simplified commands
alias remote='~/.config/openbox/scripts/remote.sh'
alias stream='~/.config/openbox/scripts/stream.sh'
# Test Awesome environment
alias va='Xephyr :1 -ac -br -noreset -screen 800x600 & sleep 3 & DISPLAY=:1.0 dbus-launch awesome -c ~/.config/awesome/rc.lua'
alias steam_clean='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete; find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete'

# Start X session on login if not SSH
if [[ -z $SSH_CONNECTION ]]; then
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi
