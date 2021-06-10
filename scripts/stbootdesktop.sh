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


_start_keepassxc () {
  if type keepassxc >/dev/null 2>&1 && ! (ps -ef | grep "keepassxc" | grep -v grep | grep -v 'extension://' | grep -q -v 'keepassxc-proxy') ; then
    keepassxc & disown
  fi
}


stbootdesktop () {
  _load_daily_shells

  # Open up terminal emulator only after ssh key has been loaded into an ssh-agent:
  startoncommandoutput "\$(ssh-add -l 2>/dev/null)" guake

  # Basic apps
  startifnone flameshot
  startifnone flux -l -25 -g -49 -k 4700  # Warm light for Curitiba's location
  startifnone fsearch
  startifnone ulauncher

  # Sec
  _start_keepassxc

  # Web
  startifnone discord
  startifnone mychrome.sh
}


stbootdesktop "$@"
