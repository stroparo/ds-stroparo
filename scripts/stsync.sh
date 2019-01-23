#!/usr/bin/env bash

PROGNAME="stsync.sh"


_git () {
  gitenforcemyuser
  st-conf-git.sh
}


_main () {
  . "${DS_HOME:-$HOME/.ds}/ds.sh"

  runr alias dotfiles git sshmodes conf-subl
  _git
  syncvscode.sh
}


_main
