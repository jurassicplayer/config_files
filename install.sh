#!/bin/bash
if [[ $1 == "pkg" ]]
then
    echo "Install packages:"
    echo "cmus"
    echo "dunst"
    echo "mpd"
    echo "ncmpcpp"
    echo "obmenu-generator"
    echo "openbox"
    echo "ranger"
    echo "tilda"
    echo "tint2"
    echo "tmux"
    echo "vim"
    echo "weechat"
    echo "Copy irc.conf for weechat, add keys for live streams, vimwiki"
elif [[ $1 == "setup" ]]
then
    echo "Setting up vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    ls -a | while read f
    do
        if [[ "$f" != "." ]] && [[ "$f" != ".." ]] && [[ "$f" != ".git" ]] && [[ "$f" != "LICENSE" ]] && [[ "$f" != "README.md" ]] && [[ "$f" != "install.sh" ]]
        then
            if [[ -a "$HOME/$f" ]] && [[ $1 != "-s" ]] && [[ $1 != "-f" ]]
            then
                echo "$HOME/$f already exists. Use '-f' to overwrite."
            else
                if [[ -f "$f" ]]
                then
                    if [[ $1 == "-s" ]]
                    then
                        echo "Symlinking $HOME/$f"
                        if [[ -a "$HOME/$f" ]]; then rm "$HOME/$f"; fi
                        ln -s "$(pwd)/$f" "$HOME/$f"
                    elif [[ $1 == "-f" ]] || [[ $1 == "" ]]
                    then
                        echo "Overwriting $HOME/$f"
                        cp "$(pwd)/$f" "$HOME/$f"
                    fi
                elif [[ -d "$f" ]]
                then
                    echo "Overwriting directory $HOME/$f"
                    cp -rf "$(pwd)/$f" "$HOME/$f"
                fi
            fi
        fi
    done
fi
