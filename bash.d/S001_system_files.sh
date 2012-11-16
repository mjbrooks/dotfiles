# source system bash files

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

