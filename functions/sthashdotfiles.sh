# Workspace deployment/rehashing functions

hashall () {
  hashdotfiles -a && . ~/.aliases-cs
  hashdotfiles -d
  hashds -r # Hash DS and reload it
}

hashdotfiles () {
  typeset dotfiles_dir="$DEV"/dotfiles
  if [ -d "$DEV"/dotfiles ] ; then
    (cd "$DEV"/dotfiles \
      && [[ $PWD = *dotfiles ]] \
      && ./entry.sh "$@" \
    )
  elif type getdotfiles >/dev/null 2>&1 ; then
    getdotfiles -f
  fi
}

hashds () {
  # Syntax: [-r] {ds-sources-dir:${DEV}/ds}

  typeset bakroot="${HOME}/.ds-backups"
  typeset dsdir="${DS_HOME:-${HOME}/.ds}"
  typeset dssrc
  typeset errors=false
  typeset loadcmd=:
  typeset timestamp=$(date '+%y%m%d-%OH%OM%OS')

  # Arg parsing
  [ "$1" = '-r' ] && loadcmd=dsload && shift
  dssrc="${1:-${DEV}/ds}"

  # Check source dir available
  if [ ! -d "$dssrc" ] ; then
    echo "FATAL: No Daily Shells sources found in '$dssrc'." 1>&2
    return 1
  fi

  # Check backup root dir
  mkdir -p "$bakroot" 2>/dev/null
  if [ ! -d "$bakroot" ] ; then
    echo "FATAL: Backup directory '$bakroot' does not exist." 1>&2
    return 1
  fi

  # Backing up
  bakdir="${bakroot}/${timestamp}"
  if [ -d "$dsdir" ] ; then
    mv -f "$dsdir" "$bakdir"
    if [ ! -d "$bakdir" ] ; then
      echo "FATAL: There was an error backing up to" 1>&2
      ls -d -l "$bakdir"
      return 1
    fi
  fi

  echo "==> Rehashing Daily Shells..."
  mkdir "$dsdir" \
    && cp -a "$dssrc"/* "$dsdir"/ \
    || errors=true

  if ! ${errors:-false} ; then
    echo "==> Rehashing Daily Shells complete"
  else
    echo
    echo "ERROR: Daily Shells rehashing failure" 1>&2
    if [ -d "$bakdir" ] ; then
      echo ${BASH_VERSION:+-e} "INFO: Restoring Daily Shells backup..." 1>&2
      if mv -f -v "$bakdir" "$dsdir" ; then
        echo "INFO: Backup restored" 1>&2
      else
        echo "FATAL: Restore failed" 1>&2
      fi
    else
      echo "FATAL: There was no previous DS version backed up" 1>&2
    fi
    echo
    return 1
  fi

  if [ -d "$dsdir" ] && [ -d "$DEV"/ds-extras ] ; then
    echo "==> Rehashing Daily Shells Extras -- ds-extras/overlay.sh ..."
    (cd "$DEV"/ds-extras && . ./overlay.sh)
  fi

  eval "$loadcmd"
}

