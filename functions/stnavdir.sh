# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################

dl    () { d "${HOME}"/Downloads -Ah ; }
h     () { d "${HOME}" -Ah ; }
myopt () { d "${MYOPT}" -Ah ; }
mysw  () { d "${MYSW}" -Ah ; }
ups   () { d "${UPS:-$HOME/upstream}" ; }

# #############################################################################
# Cygwin

if (uname -a | grep -i -q cygwin) ; then
  unset -f dl
  dl () { up Downloads ; }
fi
