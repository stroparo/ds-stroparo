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
  runr apps shell
  export STEP_BASE_SYSTEM_DONE=true
}


_step_self_provision () {
  dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
    || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
  dsload || . "${DS_HOME:-$HOME/.ds}/ds.sh" || exit $?
}


_step_setup () {
  if [ -e "${DS_HOME}/envst.sh" ] ; then
    runr dotfiles git
    st-conf-git.sh
    stsetup.sh
  fi

  if ! ${NODESKTOP:-false} ; then
    runr provision
  fi
}


_main () {
  _step_base_system
  _step_self_provision
  _step_setup
}


_main "$@"
