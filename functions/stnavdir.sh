# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Basic dirs

dl    () { d "${HOME}"/Downloads -Ah ; }
h     () { d "${HOME}" -Ah ; }
forks () { d "${FORKS:-$HOME/forks}" ; }
ups   () { d "${UPS:-$HOME/upstream}" ; }
work  () { d "${WORK:-$HOME/work}" ; }

# #############################################################################
# Specific dirs

myopt () { d "${MYOPT}" -Ah ; }
mysw  () { d "${MYSW}" -Ah ; }

# #############################################################################
# Cygwin

if (uname -a | grep -i -q cygwin) ; then
  unset -f dl   ; dl    () { d "$(cygpath "${USERPROFILE}/${1}")"/Downloads ; }
  unset -f h    ; h     () { d "$(cygpath "${USERPROFILE}/${1}")" ; }
  unset -f forks; forks () { d "${FORKS:-$HOME/forks}" ; }
  unset -f ups  ; ups   () { d "${UPS:-$HOME/upstream}" ; }
  unset -f work ; work  () { d "${WORK:-$HOME/work}" ; }
fi

# #############################################################################
