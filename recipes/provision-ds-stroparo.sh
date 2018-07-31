#!/usr/bin/env bash

PROGNAME="provision-ds-stroparo.sh"


_step_base_system () {

  if which sudo >/dev/null 2>&1 && ! sudo grep -q "$USER" /etc/sudoers; then
    echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
  fi

  mkdir ~/workspace >/dev/null 2>&1 ; ls -d -l ~/workspace || exit $?

  bash -c "$(curl -LSf "https://bitbucket.org/stroparo/dotfiles/raw/master/entry.sh" \
    || curl -LSf "https://raw.githubusercontent.com/stroparo/dotfiles/master/entry.sh")" \
    entry.sh provision-minimal

  dsload >/dev/null 2>&1 || . "${DS_HOME:-$HOME/.ds}/ds.sh" >/dev/null 2>&1
  if ! type dsload >/dev/null 2>&1 || [ -z "$DS_LOADED" ]; then
    echo "${PROGNAME:+$PROGNAME: }FATAL: Could not load Daily Shells." 1>&2
    exit 1
  fi
}


_step_self_provision () {

  dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
    || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
  dsload >/dev/null 2>&1
}


_step_own_stuff () {
  if [ -e "${DS_HOME}/envst.sh" ] ; then
    # Git:
    clonemygits "$STGITS"
    st-conf-git.sh
  fi
}


_main () {
  _step_base_system
  _step_self_provision
  _step_own_stuff
}


_main "$@"
