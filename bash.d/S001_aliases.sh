# .bashrc

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

# wine?
alias win='wine -desktop 1024x768 -depth 16'

alias myip='echo -e "\n$(curl -s ifconfig.me/ip)\n"'


# git related aliases
alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias g='git'
alias get='git'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'


#todo.txt
alias t='todo.sh -d ~/.todo/config'
#enable completion for it
complete -F _todo t
