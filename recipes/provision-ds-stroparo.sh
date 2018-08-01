#!/usr/bin/env bash

PROGNAME="provision-ds-stroparo.sh"


_step_reset () {
  if ! ${SELF_PROVISION:-false} ; then return ; fi

  mv -f ~/dotfiles-master ~/dotfiles-master.$(date '+%Y%m%d-%OH%OM%OS')
  [ -d ~/dotfiles-master ] && echo "FATAL: Could not archive working ~/dotfiles-master" && exit 1

  mv -f ~/.ds ~/.ds.$(date '+%Y%m%d-%OH%OM%OS')
  [ -d ~/.ds ] && echo "FATAL: Could not archive working Daily Shells at ~/.ds" && exit 1

}


_step_base_system () {

  if which sudo >/dev/null 2>&1 && ! sudo grep -q "$USER" /etc/sudoers; then
    echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
  fi

  mkdir ~/workspace >/dev/null 2>&1 ; ls -d -l ~/workspace || exit $?

  bash -c "$(curl -LSf "https://bitbucket.org/stroparo/dotfiles/raw/master/entry.sh" \
    || curl -LSf "https://raw.githubusercontent.com/stroparo/dotfiles/master/entry.sh")" \
    entry.sh -b -s

  if type dsload > /dev/null 2>&1 ; then
    dsload || exit $?
  else
    . "${DS_HOME:-$HOME/.ds}/ds.sh" || exit $?
  fi
}


_step_self_provision () {
  if ! ${SELF_PROVISION:-false} ; then return ; fi
  dsplugin.sh "stroparo@bitbucket.org/stroparo/ds-stroparo" \
    || dsplugin.sh "stroparo@github.com/stroparo/ds-stroparo"
  dsload >/dev/null 2>&1
}


_step_own_stuff () {
  if [ -e "${DS_HOME}/envst.sh" ] ; then
    st-conf-git.sh
  fi
}


_main () {
  _step_reset
  _step_base_system
  _step_self_provision
  _step_own_stuff
}


_main "$@"
