#!/usr/bin/env bash

PROGNAME="provision-stroparo.sh"


_step_base_system () {
  ${STEP_BASE_SYSTEM_DONE:-false} && return

  if which sudo >/dev/null 2>&1 && ! sudo grep -q "$USER" /etc/sudoers; then
    echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
  fi

  mkdir ~/workspace >/dev/null 2>&1 ; ls -d -l ~/workspace || exit $?

  bash -c "$(curl -LSf "https://raw.githubusercontent.com/stroparo/ds/master/setup.sh" \
    || curl -LSf "https://bitbucket.org/stroparo/ds/raw/master/setup.sh")"
  dsload || . "${DS_HOME:-$HOME/.ds}/ds.sh" || exit $?
  runr apps shell dotfiles git
  export STEP_BASE_SYSTEM_DONE=true
}


_step_self_provision () {
  dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
    || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
  dsload || . "${DS_HOME:-$HOME/.ds}/ds.sh" || exit $?
}


_step_own_stuff () {
  [ -e "${DS_HOME}/envst.sh" ] || return $?
  st-conf-git.sh
}


_main () {
  _step_base_system
  _step_self_provision
  _step_own_stuff
}


_main "$@"