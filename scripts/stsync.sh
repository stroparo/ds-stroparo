#!/usr/bin/env bash

PROGNAME="stsync.sh"


_conf_git () {

  gitenforcemyuser

  # Execute all installed Daily Shells plugins' *conf-git.sh scripts:
  for git_script in "${DS_HOME:-$HOME/.ds}"/*/*conf-git.sh ; do
    bash "${git_script}"
  done
}


_conf () {
  . "${DS_HOME:-$HOME/.ds}/ds.sh"
  runr \
    alias \
    dotfiles \
    git \
    sshmodes \
    vim \
    syncsubl.sh \
    syncvscode.sh

  _conf_git

}

_sync_git () {
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


_sync () {

  _sync_git \
    "${MY_LIBCOMP_REPO}" \
    "${MY_TODO_REPO}"

  syncvscode.sh
}


_conf
_sync
