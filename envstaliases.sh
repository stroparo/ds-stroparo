# Author: Cristian Stroparo

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
scb () { sudo systemctl start "$@" ; }
sce () { sudo systemctl stop "$@" ; }
scs () { sudo systemctl status "$@" ; }
sct () { sudo systemctl "$@" ; }
startdropbox () { env DBUS_SESSION_BUS_ADDRESS='' ~/.dropbox-dist/dropboxd ; }
un () { unison "$@" ; }
ung () { unison-gtk "$@" ; }

# Wrappers for DS git functions:
bvc () { gtrbvc "$@" ; }
gll () { v && [[ $PWD = *workspace ]] && gtrlpv ; }
gpp () { v && [[ $PWD = *workspace ]] && gtrppv ; }
gsp () { v && [[ $PWD = *workspace ]] && gtrspv ; }
