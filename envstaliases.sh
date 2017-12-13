# Author: Cristian Stroparo

alias vvvi='[[ $0 = *bash* ]] && set -b; set -o vi;export EDITOR=vim'
alias ydl='youtube-dl'
alias ydlaudio='youtube-dl -f 140'
alias ydlaudiobest='youtube-dl -f bestaudio'
alias ydlx='youtube-dl -x'

# Change dir:
dl () { d "${HOME}"/Downloads -Ah ; }
h () { d "${HOME}" -Ah ; }
up () { d "$(cygpath "${USERPROFILE}")" -Ah ; }

# Wrappers:
py () { python3 "$@"; }
py2 () { python2 "$@"; }
py3 () { python3 "$@"; }
startdropbox () { env DBUS_SESSION_BUS_ADDRESS='' ~/.dropbox-dist/dropboxd ; }
un () { unison "$@" ; }
ung () { unison-gtk "$@" ; }

# Wrappers for DS:
gll () { v && [[ $PWD = *workspace ]] && grlpv ; }
gpp () { v && [[ $PWD = *workspace ]] && grppv ; }
gsp () { v && [[ $PWD = *workspace ]] && grspv ; }

