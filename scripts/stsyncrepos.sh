#!/usr/bin/env bash

PROGNAME="stsyncrepos.sh"


# TODO later on dismember this generyc git sync function into maybe a Daily Shells routine, for example..
_sync_git () {
  typeset repo="$1"
  if [ -d "$repo" ] ; then
    (
      echo
      cd "$repo"
      echo "${PROGNAME:+$PROGNAME: }INFO: Now syncing git repo '${repo}'"
      echo "${PROGNAME:+$PROGNAME: }INFO: Working dir is '$(pwd)'"
      git pull origin master
      echo "${PROGNAME:+$PROGNAME: }INFO: git status before push, in '${repo}':"
      git push origin master
      echo "${PROGNAME:+$PROGNAME: }INFO: git status after push, in '${repo}':"
      git status -s
      echo
    )
  fi
}


echo
echo "${PROGNAME:+$PROGNAME: }INFO: Repository syncing routine" 1>&2
echo

_sync_git \
  "${MY_LIBCOMP_REPO}" \
  "${MY_TODO_REPO}"
