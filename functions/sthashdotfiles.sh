# Workspace deployment/rehashing functions


hashdotfiles () {
  if [ ! -d ~/.runr ] && [ -d "$DEV"/runr ] ; then
    cp -a "$DEV"/runr ~/.runr
  fi
  if [ -d ~/.runr ] ; then
    chmod 755 ~/.runr/entry.sh
    (cd ~/.runr \
      && [[ $PWD = *.runr ]] \
      && bash -c "$(cat ./entry.sh)" entry.sh "$@"
    )
  else
    bash -c "$(curl -LSf "https://bitbucket.org/stroparo/runr/raw/master/entry.sh" \
      || curl -LSf "https://raw.githubusercontent.com/stroparo/runr/master/entry.sh")" \
      entry.sh apps shell dotfiles git
  fi
}

