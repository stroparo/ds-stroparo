if (uname -a | grep -i -q linux) ; then
  dl    () { d "${HOME}"/Downloads "$@" ; }
  h     () { d "${HOME}" "$@" ; }
elif (uname -a | egrep -i -q "cygwin") ; then
  dl    () { d "$(cygpath "${USERPROFILE}")"/Downloads "$@" ; }
  h     () { d "${HOME}" "$@" ; }
elif (uname -a | egrep -i -q "mingw|msys|win32|windows") ; then
  dl    () { d "$(cygpath "${USERPROFILE}")"/Downloads "$@" ; }
  h     () { d "$(cygpath "${USERPROFILE}")" "$@" ; }
fi

dx () { d "${DROPBOXHOME}" "$@" ; }
dx2 () {
  d "${DROPBOXHOME}" "$@"
  if echo "$PWD" | fgrep -q "${DROPBOXHOME##*/}" ; then
    find . -type d -maxdepth 2 \
      | egrep -v "backups|bak|dropbox[.]cache"
  fi
}
myopt () { d "${MYOPT}" "$@" ; }
mysw  () { d "${MYSW}" "$@" ; }
