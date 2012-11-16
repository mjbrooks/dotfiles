export BASHRC_IMPORTED

#if the directory ~/.bash.d exists
if [ -d ~/.bash.d ] ; then
	#source every file in ~/dotfiles/bash.d beginning matching S*[^~]
	for f in ~/dotfiles/bash.d/S*[^~] ; do
		source $f
	done
fi
