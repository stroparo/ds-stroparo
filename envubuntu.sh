if ! [[ "$(uname -a)" = *[Uu]buntu* ]] ; then return ; fi

pathmunge -x -v 'LD_LIBRARY_PATH' '/usr/lib/x86_64-linux-gnu'
