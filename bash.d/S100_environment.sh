
#This line will tell the Go installer where to place the source code
# before compilation
export GOROOT=$HOME/go/gosource

#With this line, you choose the architecture of your machine.
#Those with 64 bit CPUs should enter "amd64" here.
#export GOARCH=386
export GOARCH=amd64

#Your operating system
export GOOS=linux

#And now the location where the installer will place the finished files
#Don't forget to create this directory before installing
export GOBIN=$HOME/go/gobin



HOME_DIR=$(/bin/ls -d ~)

#PATH="$HOME_DIR/bin:$HOME_DIR/usr/bin:$PATH"
PATH="$HOME_DIR/bin:$PATH"
PATH="$PATH:/bin:/usr/bin:/usr/local/bin"
PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin"
PATH="$PATH:/usr/X11R6/bin"

#Include Go binaries in command path
PATH=$PATH:$GOBIN

export PATH

export MANPATH="$HOME_DIR/usr/share/man:$HOME_DIR/usr/man:/usr/share/man:/usr/man"
