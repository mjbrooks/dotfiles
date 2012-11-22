#.bashrc

NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
K="\[\033[0;30m\]"    # black
R="\[\033[0;31m\]"    # red
G="\[\033[0;32m\]"    # green
Y="\[\033[0;33m\]"    # yellow
B="\[\033[0;34m\]"    # blue
M="\[\033[0;35m\]"    # magenta
C="\[\033[0;36m\]"    # cyan
W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
EMK="\[\033[1;30m\]"
EMR="\[\033[1;31m\]"
EMG="\[\033[1;32m\]"
EMY="\[\033[1;33m\]"
EMB="\[\033[1;34m\]"
EMM="\[\033[1;35m\]"
EMC="\[\033[1;36m\]"
EMW="\[\033[1;37m\]"
    
    # background colors
BGK="\[\033[40m\]"
BGR="\[\033[41m\]"
BGG="\[\033[42m\]"
BGY="\[\033[43m\]"
BGB="\[\033[44m\]"
BGM="\[\033[45m\]"
BGC="\[\033[46m\]"
BGW="\[\033[47m\]"

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}

function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo "+"
}

function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*" 
}

function parse_git_dirty {
  echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/git::(\1$(parse_git_dirty)) /"
}


prompt ()
{
    case "$1" in
        d)
            PROMPT_COMMAND='history -a'
            PS1="$(dirs) \$ "
        ;;
        n)
            PROMPT_COMMAND='history -a'
            PS1="\$ "
        ;;
        hsw)
            PROMPT_COMMAND='history -a'
            PS1="${HCOLOR}\h${NONE}[$SHLVL]: \w \$ "
        ;;
        hw)
            PROMPT_COMMAND='history -a'
            PS1="${HCOLOR}\h${NONE}: \w \$ "
        ;;
        sh)
            PROMPT_COMMAND='history -a'
            PS1="[$SHLVL] ${HCOLOR}\h${NONE}\$ "
        ;;
        sw)
            PROMPT_COMMAND='history -a'
            PS1="[$SHLVL] \w \$ "
        ;;
        uh)
            PROMPT_COMMAND='history -a'
            PS1="\u${HCOLOR}@\h${NONE}$ "
        ;;
        uhg)
            PROMPT_COMMAND='history -a'
            PS1="\u${HCOLOR}@\h${NONE}: ${M}\$(parse_git_branch)${NONE}\$ "
        ;;
        uhsHw)
            PROMPT_COMMAND='history -a'
            PS1="\u${HCOLOR}@\h${NONE}[$SHLVL]:\#: \w \$ "
        ;;
        uhsw)
            PROMPT_COMMAND='history -a'
            PS1="\u${HCOLOR}@\h${NONE}[$SHLVL]: \w \$ "
        ;;
        uhw)
            PROMPT_COMMAND='history -a'
            PS1="\u${HCOLOR}@\h${NONE}: \w \$ "
        ;;
        uhwg)
            PROMPT_COMMAND='history -a'
            PS1="\u${HCOLOR}@\h${NONE}: \w ${M}\$(parse_git_branch)${NONE}\$ "
        ;;
        uw)
            PROMPT_COMMAND='history -a'
            PS1="(\u) \w \$ "
        ;;
        w)
            PROMPT_COMMAND='history -a'
            PS1="\w \$ "
        ;;
        #looks cool, but somewhat broken at the moment, not to mention takes a ton of space
        super)
            PROMPT_COMMAND='history -a;echo -en "\033[m\033[38;5;2m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg) \033[m"'
            PS1="\[\e[m\n\e[1;30m\][$$:$PPID${EMK}]${C} \T \d ${EMK}[${UCOLOR}\u${HCOLOR}@\H${EMK}:${W}${SSH_TTY} ${G}+${SHLVL}${EMK}] ${NONE}\w \n\`if [ \$? = 0 ]; then echo -e '\e[01;32m:)'; else echo -e '\e[01;31m:('; fi\` ${W}(\#|\!) ${M}\$(parse_git_branch)${W}\$ "
        ;;
    esac
}



if [ "$PS1" ]; then


    case "$TERM" in
	    *xterm*)
	    # update xterm titles
	    XTERM_PS1="\[\033]0;\u@\h: \w\007\]"
	    PROMPT_COMMAND='history -a;echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'

	    ;;
	    *)
	    XTERM_PS1=""
    #		PROMPT_COMMAND=""

	    ;;
    esac


    # change prompt/colors based on hostname
    case `hostname` in
	io|badkarma|om|dharma)
	    UCOLOR=$NONE
	    HCOLOR=$EMW
	    ;;

	daimyo|shogun)
	    UCOLOR=$EMW
	    HCOLOR=$EMR
	    ;;

	*-archive|archive*)
	    UCOLOR=$EMY
	    HCOLOR=$EMR
	    ;;

	grok|intersect|sol|ion)
	    UCOLOR=$EMW
	    HCOLOR=$Y
	    ;;

	#default prompt
	*)
	    UCOLOR=$NONE
	    HCOLOR=$NONE
	    ;;

    esac


    #set the initial prompt
    prompt uhwg

fi


