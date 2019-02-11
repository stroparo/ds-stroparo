# Home dirs
if (uname -a | grep -i -q linux) ; then
  dl    () { d "${HOME}"/Downloads "$@" ; }
  h     () { d "${HOME}" "$@" ; }
elif (uname -a | egrep -i -q "cygwin") ; then
  dl    () { d "$(cygpath "${USERPROFILE}")"/Downloads "$@" ; }
  h     () { d "${HOME}" "$@" ; }
  wh    () { d "$(cygpath "${USERPROFILE}")" "$@" ; }
elif (uname -a | egrep -i -q "mingw|msys|win32|windows") ; then
  dl    () { d "$(cygpath "${USERPROFILE}")"/Downloads "$@" ; }
  h     () { d "$(cygpath "${USERPROFILE}")" "$@" ; }
  wh    () { d "$(cygpath "${USERPROFILE}")" "$@" ; }
fi

# Custom dirs
handy () { v handy "$@" ; }
comp () { d "${MY_LIBCOMP_REPO}" ; }
conf () { v handy conf "$@" ; }
lnk () { v handy/conf/win-lnk "$@" ; explorer "$(cygpath -w "$PWD")" ; }
todo () { d "${MY_TODO_REPO}" ; }

# Dropbox
dx () { d "${DROPBOXHOME}" "$@" ; }
dx2 () {
  d "${DROPBOXHOME}" "$@"
  if echo "$PWD" | fgrep -q "${DROPBOXHOME##*/}" ; then
    find . -type d -maxdepth 2 \
      | egrep -v "backups|bak|dropbox[.]cache"
  fi
}

# My dirs
myopt () { d "${MYOPT}" "$@" ; }
mysw  () { d "${MYSW}" "$@" ; }

# Programming editor in the current dir
cod () { "${VISUAL}" . ; }

