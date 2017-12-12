# Author: Cristian Stroparo

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

