# Disk plus dirs to nav:
mnt () { d "${MOUNTS_PREFIX:-/}" "$@" ; }

# Home dirs
if [ -f /usr/bin/cygpath ] ; then
  h  () { d "${HOME}" "$@" ; }
  wh () { d "$(cygpath "${USERPROFILE}")" "$@" ; }
else
  h  () { d "${HOME}" "$@" ; }
fi

# Workspace
v () { d "${DEV:-$HOME/workspace}" "$@" ; }

# Cloud
zdg () { d "${GDRIVEHOME}" "$@" ; }
zdx () { d "${DROPBOXHOME}" "$@" ; }
zdxfind2 () {
  d "${DROPBOXHOME}" "$@"
  if echo "$PWD" | fgrep -q "${DROPBOXHOME##*/}" ; then
    find . -type d -maxdepth 2 \
      | egrep -v "backups|bak|dropbox[.]cache"
  fi
}

# My dirs
zdo () { d "${MYOPT}" "$@" ; }
