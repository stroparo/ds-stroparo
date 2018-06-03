# Daily Shells Stroparo extensions

# #############################################################################
# Basic dirs

dl    () { d "${HOME}"/Downloads "$@" ; }
h     () { d "${HOME}" "$@" ; }
forks () { d "${FORKS:-$HOME/forks}" "$@" ; }
gists () { d "${GISTS:-$HOME/gists}" "$@" ; }
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
