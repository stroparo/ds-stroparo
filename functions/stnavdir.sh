# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Basic dirs

dl    () { d "${HOME}"/Downloads ; echo ; d "$@" ; }
h     () { d "${HOME}" ; echo ; d "$@" ; }
forks () { d "${FORKS:-$HOME/forks}" ; echo ; d "$@" ; }
gists () { d "${GISTS:-$HOME/gists}" ; echo ; d "$@" ; }
ups   () { d "${UPS:-$HOME/upstream}" ; echo ; d "$@" ; }
work  () { d "${WORK:-$HOME/work}" ; echo ; d "$@" ; }

# #############################################################################
# Specific dirs

myopt () { d "${MYOPT}" ; echo ; d "$@" ; }
mysw  () { d "${MYSW}" ; echo ; d "$@" ; }

# #############################################################################
# Cygwin

if (uname -a | grep -i -q cygwin) ; then
  unset -f dl h
  dl    () { d "$(cygpath "${USERPROFILE}/${1}")"/Downloads ; echo ; d "$@" ; }
  h     () { d "$(cygpath "${USERPROFILE}/${1}")" ; echo ; d "$@" ; }
fi

# #############################################################################
