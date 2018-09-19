# Workspace deployment/rehashing functions

hashall () {
  hashdotfiles alias && . ~/.aliases-cs
  hashdotfiles dotfiles
  hashds -r # Hash DS and reload it
}

hashdotfiles () {
  typeset runr_dir="$DEV"/runr
  if [ -d "$DEV"/runr ] ; then
    (cd "$DEV"/runr \
      && [[ $PWD = *runr ]] \
      && ./entry.sh "$@" \
    )
  elif type getdotfiles >/dev/null 2>&1 ; then
    getdotfiles shell alias apps dotfiles
  fi
}

hashds () {
  # Syntax: [-r] [ds-sources-dir:${DEV}/ds]

  typeset progname="hashds"

  # Simple option parsing must come first:
  typeset loadcmd=:
  [ "$1" = '-r' ] && loadcmd="echo DS loading... ; dsload" && shift

  typeset dshome="${DS_HOME:-${HOME}/.ds}"
  typeset dssrc="${1:-${DEV}/ds}"
  typeset errors=false

  # Requirements
  if [ ! -d "${dssrc}" ] ; then
    echo "${progname}: FATAL: No Daily Shells sources found in '${dssrc}'." 1>&2
    return 1
  fi
  dsbackup_dir="$(dsbackup)"; dsbackup_res=$?
  if [ "${dsbackup_res:-1}" -ne 0 ] || [ ! -d "${dsbackup_dir}" ] ; then
    echo "${progname}: FATAL: error in dsbackup." 1>&2
    return 1
  fi

  echo
  echo "==> Daily Shells rehash started..."
  rm -f -r "${dshome}" \
    && : > "${DS_PLUGINS_INSTALLED_FILE}" \
    && mkdir "${dshome}" \
    && cp -a "${dssrc}"/* "${dshome}"/ \
    || errors=true

  if ! ${errors:-false} ; then
    echo
    echo "==> Daily Shells rehash complete"
    dshashplugins.sh "${DEV}"
    eval "$loadcmd"
  else
    echo "${progname}: ERROR: Daily Shells rehash failure" 1>&2
    dsrestorebackup
    return 0
  fi
}

