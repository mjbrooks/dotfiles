# .bashrc

if [ "$PS1" ]; then

        # ---------------------------------------------------------------------------
        # custom tab completion ....
        #
        # cheatsheet...
        #	COMP_LINE
        #	COMP_POINT
        #	COMP_WORDS
        #	COMP_CWORD
        #	$1 - command completed
        #	$2 - word being completed
        #	$3 - word before the one being completed
        #	COMPREPLY - result

        # create a function that allows for man page completion
        complete -o default -F _complete_man_pages man
        _complete_man_pages() {
          if test -z "$2" ; then
            return
          fi
          if test -z "$3" || test "$1" = "$3" ; then
            COMPREPLY=( $( apropos "$2" | cut -d ' ' -f 1 | /bin/grep "^$2" ) )
          else
            COMPREPLY=( $( apropos "$3" "$2" | cut -d ' ' -f 1 | /bin/grep "^$2" ) )
          fi
        }

        #    # create a function that handles tab completion on ssh
        #    #complete -o default -F _complete_ssh_hosts ssh
        #    #complete -o default -F _complete_ssh_hosts scp
        #    _complete_ssh_hosts() {
        #      if test -z "$2" ; then
        #        return
        #      fi
        #      KNOWN_HOSTS="~/.ssh/known_hosts"
        #      KNOWN_HOSTS2="~/.ssh/known_hosts2"
        #      if ! test -r "$KNOWN_HOSTS" -o -r "$KNOWN_HOSTS2" ; then
        #        return
        #      fi
        #      PREFIX=""
        #      SSHHOST=$( echo "$2" | cut -d '@' -f 2- )
        #      if test "$SSHHOST" != "$2" ; then
        #        PREFIX=$( echo "$2" | cut -d '@' -f 1 )"@"
        #      fi
        #      COMPREPLY=( $( cat "$KNOWN_HOSTS" "$KNOWN_HOSTS2" | cut -d ' ' -f 1 \
        #    		| tr ',' '\n' | /bin/grep "^$SSHHOST" | sed -e "s/^/$PREFIX/;" ) )
        #    }

        if false ; then
        # create a function that handles tab completion on make
        complete -o default -F _complete_make_targets make
        _complete_make_targets() {
          if test -z "$2" ; then
            return
          fi
          DIR="."
          if (echo $COMP_LINE | /bin/grep 'make .*-C *[^ ]\+ ' > /dev/null) ; then
            DIR=$(echo $COMP_LINE | sed -e 's/^.*-C *//;' | cut -d ' ' -f 1)
          fi
          FILE=""
          if (echo $COMP_LINE | /bin/grep 'make .*-f *[^ ]\+ ' > /dev/null) ; then
            FILE=$(echo $COMP_LINE | sed -e 's/^.*-f *//;' | cut -d ' ' -f 1)
          fi
          FILE=$(for try in "$FILE" "GNUmakefile" "makefile" "Makefile" ; do
        	  if test -f "$DIR/$try" -a -r "$DIR/$try" ; then
        	    echo "$DIR/$try"
                  fi
        	done | head -n1)
          if ! test -f "$FILE" -a -r "$FILE" ; then
            return
          fi
          COMPREPLY=( $( cat "$FILE" | /bin/grep -i "^$2[a-z0-9_]*:" | cut -d : -f 1  ) )
        }
        fi

        # create a function that handles tab completion on make
        complete -o default -F _complete_vim_tags vim
        _complete_vim_tags() {
          if test -z "$2" ; then
            return
          fi
          if test "$COMP_CWORD" -lt 2 ; then 
            return
          fi

          WORD=${COMP_WORDS[$COMP_CWORD]}
          if test -z "$WORD" ; then
            return
          fi

          PRE_NDX=$(($COMP_CWORD - 1))
          PRE_WORD=${COMP_WORDS[$PRE_NDX]}
          if test -z "$PRE_WORD" -o "$PRE_WORD" != "-t" ; then
            return
          fi

          #TMPFILE="/tmp/vimtags-$$"
          #VIMCMD="vim -c ':call setline(1,&tags)' -c ':w!' -c ':q!' $TMPFILE"
          #TAGFILES=$( $VIMCMD ; cat $TMPFILE | tr ',' '\n' ; rm -f $TMPFILE)
          TAGFILES="./tags tags ../tags ../../tags /usr/src/linux/tags /usr/include/tags"

          #echo $TAGFILES >&2

          COMPREPLY=( $( cat $TAGFILES 2>/dev/null | /bin/grep -i "^$2[a-z0-9_]*\t" | cut -d '	' -f 1  ) )
        }

fi
