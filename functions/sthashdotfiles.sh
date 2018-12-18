# Workspace deployment/rehashing functions


hashdotfiles () {
  if [ -d ~/.runr ] && ! mv ~/.runr ~/.runr.$(date '+%Y%m%d-%OH%OM%OS') ; then
    echo "${PROGNAME:+$PROGNAME: }FATAL: Could not backup '${HOME}/.runr'." 1>&2
    return 1
  fi

  if [ -d "$DEV"/runr ] && cp -a "${DEV}"/runr ~/.runr && [ -f ~/.runr/entry.sh ] ; then
    chmod 755 ~/.runr/entry.sh
    (cd ~/.runr \
      && [[ $PWD = *.runr ]] \
      && bash -c "$(cat ./entry.sh)" entry.sh apps shell dotfiles git vim "$@"
    )
  else
    bash -c "$(curl -LSf "https://bitbucket.org/stroparo/runr/raw/master/entry.sh" \
      || curl -LSf "https://raw.githubusercontent.com/stroparo/runr/master/entry.sh")" \
      entry.sh apps shell dotfiles git vim "$@"
  fi
}

