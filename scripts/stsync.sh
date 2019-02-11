#!/usr/bin/env bash

PROGNAME="stsync.sh"


_git () {

  gitenforcemyuser

  # Execute all installed Daily Shells plugins' *conf-git.sh scripts:
  for git_script in "${DS_HOME:-$HOME/.ds}"/*/*conf-git.sh ; do
    bash "${git_script}"
  done
}


_sync_repos () {
  (cd "${MY_TODO_REPO}"; git pull)
  (cd "${MY_LIBCOMP_REPO}"; git pull)
}


_main () {
  . "${DS_HOME:-$HOME/.ds}/ds.sh"

  runr \
    alias \
    dotfiles \
    git \
    sshmodes \
    vim \
    conf-subl \
    conf-vscode

  syncvscode.sh

  _git
  _sync_repos
}


_main
