# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Basic dirs

dl    () { d "${HOME}"/Downloads ; d "$@" ; }
h     () { d "${HOME}" ; d "$@" ; }
forks () { d "${FORKS:-$HOME/forks}" ; d "$@" ; }
gists () { d "${GISTS:-$HOME/gists}" ; d "$@" ; }
ups   () { d "${UPS:-$HOME/upstream}" ; d "$@" ; }
work  () { d "${WORK:-$HOME/work}" ; d "$@" ; }

# #############################################################################
# Specific dirs

myopt () { d "${MYOPT}" ; d "$@" ; }
mysw  () { d "${MYSW}" ; d "$@" ; }

# #############################################################################
# Cygwin

if (uname -a | grep -i -q cygwin) ; then
  unset -f dl   ; dl    () { d "$(cygpath "${USERPROFILE}/${1}")"/Downloads ; d "$@" ; }
  unset -f h    ; h     () { d "$(cygpath "${USERPROFILE}/${1}")" ; d "$@" ; }
  unset -f forks; forks () { d "${FORKS:-$HOME/forks}" ; d "$@" ; }
  unset -f ups  ; ups   () { d "${UPS:-$HOME/upstream}" ; d "$@" ; }
  unset -f work ; work  () { d "${WORK:-$HOME/work}" ; d "$@" ; }
fi

# #############################################################################
