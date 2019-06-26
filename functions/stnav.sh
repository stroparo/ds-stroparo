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

# Workspace
v () { d "${DEV:-$HOME/workspace}" "$@" ; }
handy () { d "${HANDY_REPO_DIR}" "$@" ; }
conf () { d "${HANDY_REPO_DIR}" conf "$@" ; }
lnk () { d "${HANDY_REPO_DIR}"/conf/win-lnk "$@" ; explorer "$(cygpath -w "$PWD")" ; }

# Dropbox
n2dx () { d "${DROPBOXHOME}" "$@" ; }
n2dxfind2 () {
  d "${DROPBOXHOME}" "$@"
  if echo "$PWD" | fgrep -q "${DROPBOXHOME##*/}" ; then
    find . -type d -maxdepth 2 \
      | egrep -v "backups|bak|dropbox[.]cache"
  fi
}

# My dirs
n2opt () { d "${MYOPT}" "$@" ; }
n2sw  () { d "${DROPBOXHOME}/sw" "$@" ; }
