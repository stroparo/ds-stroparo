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


stbootdesktop () {
  # Screen blue light filter for Curitiba's latitude/longitude
  _start_app flux -l -25 -g -49 -k 4700 & disown

  if _load_daily_shells ; then
    chromedark.sh
  fi
  _start_app codium
  _start_app insomnia
  _start_app keepassxc

  # Open up terminal emulator only after the key has been added by ssh-agent:
  _load_daily_shells
  while [ -z ssh-add -l 2>/dev/null ] ; do sleep 3 ; done
  _start_app guake
}


stbootdesktop "$@"
