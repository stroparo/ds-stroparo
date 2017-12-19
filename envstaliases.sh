# Author: Cristian Stroparo

alias scb='sudo systemctl start'
alias sce='sudo systemctl stop'
alias scs='sudo systemctl status'
alias sct='sudo systemctl'
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

