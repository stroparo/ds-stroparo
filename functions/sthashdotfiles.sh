# Workspace deployment/rehashing functions


hashdotfiles () {
  if [ ! -d ~/.runr ] && [ -d "$DEV"/runr ] ; then
    cp -a "$DEV"/runr ~/.runr
    chmod 755 ~/.runr/entry.sh
  fi
  if [ -d ~/.runr ] ; then
    (cd ~/.runr \
      && [[ $PWD = *.runr ]] \
      && ./entry.sh -p "$@" \
    )
  else
    bash -c "$(curl -LSf "https://bitbucket.org/stroparo/runr/raw/master/entry.sh" \
      || curl -LSf "https://raw.githubusercontent.com/stroparo/runr/master/entry.sh")" \
      entry.sh apps shell dotfiles git
  fi
}

