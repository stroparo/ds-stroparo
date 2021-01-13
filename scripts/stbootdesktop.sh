#!/usr/bin/env bash

# Purpose: Boot desktop applications

_load_daily_shells () {
  if type dsversion >/dev/null 2>&1 ; then
    return 0
  fi
  if [ ! -e "${DS_HOME:-$HOME/.ds}"/ds.sh ] ; then
    return 1
  fi
  . "${DS_HOME:-$HOME/.ds}"/ds.sh
}


_start_app () {
  if type "$1" >/dev/null 2>&1 && ! pgrep -fl "$1" ; then
    "$@" & disown
  fi
}


_start_guake () {
  # Open up terminal emulator only after ssh key has been loaded into an ssh-agent:
  while [ -z "$(ssh-add -l 2>/dev/null)" ] ; do sleep 3 ; done
  _start_app guake
}


_start_keepassxc () {
  if type keepassxc >/dev/null 2>&1 && ! (ps -ef | grep "keepassxc" | grep -v grep | grep -v 'extension://' | grep -q -v 'keepassxc-proxy') ; then
    keepassxc & disown
  fi
}


stbootdesktop () {
  _load_daily_shells

  # Basic apps
  _start_guake
  _start_app flameshot
  _start_app flux -l -25 -g -49 -k 4700  # Warm light for Curitiba's location
  _start_app fsearch
  _start_app ulauncher

  # Sec
  _start_keepassxc

  # Web
  _start_app discord
  _start_app mychrome.sh
}


stbootdesktop "$@"
