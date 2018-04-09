# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Basic dirs

dl    () { d "${HOME}"/Downloads "$@" ; }
h     () { d "${HOME}" "$@" ; }
forks () { d "${FORKS:-$HOME/forks}" "$@" ; }
gists () { d "${GISTS:-$HOME/gists}" "$@" ; }
ups   () { d "${UPS:-$HOME/upstream}" "$@" ; }
work  () { d "${WORK:-$HOME/work}" "$@" ; }

# #############################################################################
# Specific dirs

myopt () { d "${MYOPT}" "$@" ; }
mysw  () { d "${MYSW}" "$@" ; }

# #############################################################################
# Cygwin

if (uname -a | grep -i -q cygwin) ; then
  unset -f dl h
  dl    () { d "$(cygpath "${USERPROFILE}")"/Downloads "$@" ; }
  h     () { d "$(cygpath "${USERPROFILE}")" "$@" ; }
fi

# #############################################################################
