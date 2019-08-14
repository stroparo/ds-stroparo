if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  pathmunge -x -v 'LD_LIBRARY_PATH' '/usr/lib/x86_64-linux-gnu'
fi
