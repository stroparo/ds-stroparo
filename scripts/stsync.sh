#!/usr/bin/env bash

PROGNAME="stsync.sh"


_git () {
  runr git
  gitenforcemyuser
  st-conf-git.sh
}


_main () {
  . "${DS_HOME:-$HOME/.ds}/ds.sh"

  runr alias
  runr dotfiles
  runr sshmodes

  _git

  runr conf-subl
  syncvscode.sh
}


_main
