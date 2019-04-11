#!/usr/bin/env bash

PROGNAME="stsync.sh"

DOTFILES_RECIPES="
alias
dotfiles
git
sshmodes
vim
"


_conf_dotfiles () {
  echo
  echo "${PROGNAME:+$PROGNAME: }INFO: Applying dotfiles configurations..." 1>&2
  echo
  . "${DS_HOME:-$HOME/.ds}/ds.sh"
  runr ${DOTFILES_RECIPES}
}


_conf_git () {
  echo
  echo "${PROGNAME:+$PROGNAME: }INFO: Applying Daily Shells Git configurations..." 1>&2
  echo
  gitenforcemyuser
  for git_script in "${DS_HOME:-$HOME/.ds}"/*/*conf-git.sh ; do
    bash "${git_script}"
  done
}


_sync_git () {
  echo
  echo "${PROGNAME:+$PROGNAME: }INFO: Sync custom Git repositories..." 1>&2
  echo
  for repo in "$@" ; do
    if [ -d "$repo" ] ; then
      (
        cd "$repo"
        pwd
        git pull origin master
        git push origin master
        echo "git status:"
        git status -s
        echo
      )
    fi
  done
}


_seq_conf () {
  echo
  echo "${PROGNAME:+$PROGNAME: }INFO: Configuration sync..." 1>&2
  _conf_dotfiles
  _conf_git
}


_seq_sync () {
  echo
  echo "${PROGNAME:+$PROGNAME: }INFO: Other sync..." 1>&2
  _sync_git \
    "${MY_LIBCOMP_REPO}" \
    "${MY_TODO_REPO}"
}


_seq_conf
_seq_sync
