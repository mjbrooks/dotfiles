# .bashrc

if [ "$PS1" ]; then

    alias gam="python gam.py"

    # color make ?
    if ( which colormake > /dev/null 2>&1 ) ; then
        alias cmake='colormake'
    fi

    export LS_OPTIONS='--color=auto'
    eval `dircolors`
    alias ls='ls -F $LS_OPTIONS'
    alias ll='ls -F $LS_OPTIONS -l'

    #alias grep='grep --color=auto'
    if ( which clr > /dev/null 2>&1 ) ; then
        alias cgrep='clr grep'
    fi

    alias rm='rm -i'
    #alias cp='cp -i'
    #alias mv='mv -i'
    alias ..='cd ..'

    alias please='sudo'

    # print pretty calendars
    alias pcal-portrait="pcal -F 1 -m -J -p"
    alias pcal-landscape="pcal -F 1 -m -J -l"

    # wine?
    alias win='wine -desktop 1024x768 -depth 16'

    alias myip='echo -e "\n$(curl -s ifconfig.me/ip)\n"'
fi
