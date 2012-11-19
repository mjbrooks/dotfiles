# .bashrc

if [ "$PS1" ]; then

        # http://www.jmglov.net/unix/bash.html

        # ------------------------------------------------------------------------
        # history configuration

        # ignore these commands when adding to history
        HISTIGNORE='\&:fg:bg:ls:clear:exit:mroe*:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -l'
        HISTIGNORE=${HISTIGNORE}':%1:%2:popd:top:htop:halt:shutdown:reboot*'
        export HISTIGNORE

        # Save multi-line commands in history as single line
        shopt -s cmdhist

        # 10k lines of history
        export HISTSIZE=10000
        export HISTFILESIZE=${HISTSIZE}

        # Reduce redundancy in the history file
        export HISTCONTROL=ignoredups

        # Do not delete your precious history file before writing the new one
        shopt -s histappend

        # This is useful for embedded newlines in commands and quoted arguments
        shopt -s lithist

        # Enable egrep-style pattern matching
        shopt -s extglob

fi
