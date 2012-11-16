# .bashrc

if [ "$PS1" ]; then

        if [ -x $HOME/bin/vim ] ; then
                export EDITOR=$HOME/bin/vim
        elif ( which vim > /dev/null ) ; then
                export EDITOR=vim
        fi

        export PAGER=less
        export VPAGER="vim -R -"
        export RSYNC_RSH=ssh

        export MAIL="${HOME}/mail/inbox"

        export CVS_RSH=ssh
        export CVSREAD=yes

        # ---- time ------------------------------------------------------------
        export TIME="\n%Uuser %Ssystem %Eelapsed %PCPU (%Xtext+%Ddata %Mmax)\n%Iinputs+%Ooutputs (%Fmajor+%Rminor)pagefaults %Wswaps"
        alias t="/usr/bin/time"

        function wt() { while true ; do ( $@ ) ; sleep 1 ; clear ; done ; }
        function tt() { bash -c "time $*" ; }

        function yyyymmdd { date +%Y%m%d ; }
        function yyyymmdd-hhmmss { date +%Y%m%d-%H%M%S ; }

        alias ymd=yyyymmdd
        alias ymd-hms=yyyymmdd-hhmmss

        # ---- paging ------------------------------------------------------------

        function least() {
                declare -a lines

                if ! [ -z "$@" ] ; then
                        cat $@ | least
                        return 0
                fi

                if [ -z "$LINES" ] || ! ( echo $LINES | grep -q '^[0-9]\+$' ) ; then
                        LINES=20
                fi

                function dump_array () {
                        for n in `seq 1 "${#lines[@]}"` ; do
                                echo "${lines[$n]}"
                        done
                }

                #pre_IFS=$IFS
                #IFS=
                while read x ; do
                        #IFS=$pre_IFS

                        lines[((${#lines[@]}+1))]="$x"

                        if [ "${#lines[@]}" -ge $LINES ] ; then
                                ( dump_array ; cat ) | $VPAGER
                                exit 0
                        fi
                done
                #IFS=$pre_IFS

                dump_array
        }

        function v() { $@ | least ; }
        function vv() { $@ | vim -R - ; }

        function maxhead() { head -n `echo $LINES - 2|bc` ; }
        function maxtail() { tail -n `echo $LINES - 2|bc` ; }


        # ---- other ------------------------------------------------------------

        # <dave0> if you use this bash function, you can do 'dpan DBD::ODBC' 
        #         and it will get the debian package if it exists
        function dpan () {
            PKG=`perl -e '$_=lc($ARGV[0]); s/::/-/g; print "lib$_-perl\n"' $1`;
            echo apt-get install $PKG;
        }

        # <lpaseen> gives last time the cmdline was changed in seconds since epoc and since the process is a daemond it doesn't 
        #           change once it started
        getetime() {
            pid=$(pgrep -o $1)
            if [ -z "$pid" ];then
                echo "-1"
                return 1
            fi
            let etime=$(date +%s)-$(stat -c %Y /proc/$pid/cmdline)
            echo $etime
        }


fi
