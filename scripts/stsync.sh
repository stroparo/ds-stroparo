#!/usr/bin/env bash

PROGNAME="stsync.sh"


_git_conf () {

  gitenforcemyuser

  # Execute all installed Daily Shells plugins' *conf-git.sh scripts:
  for git_script in "${DS_HOME:-$HOME/.ds}"/*/*conf-git.sh ; do
    bash "${git_script}"
  done
}


_git_sync () {
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

  _git_conf
  _git_sync \
    "${MY_LIBCOMP_REPO}" \
    "${MY_TODO_REPO}"

}


_main
