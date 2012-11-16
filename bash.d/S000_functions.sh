#This ll function produces a long-format directory listing
function ll
{
  command ls -Flh "$@"
}
export -f ll

#doc can be made to change to the specified package’s documentation directory
#and display the files therein
function doc
{
  pushd "/usr/share/doc/$1" && ls
}
export -f doc

#convenience function for joining together two movie files
function joinmovie
{
    echo "Enter path and name of two videos to combine"
    read video1 video2
    echo "What do you want to name the new video (include extension)?"
    read name
    mencoder -forceidx -oac copy -ovc copy -o $name $video1 $video2
    echo "All done!"
}
export -f joinmovie
