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

