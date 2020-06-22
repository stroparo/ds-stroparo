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


stbootdesktop () {
  _load_daily_shells
  _start_app chromedark.sh
  _start_app codium
  _start_app discord
  _start_app flux -l -25 -g -49 -k 4700  # Warm light for Curitiba's location
  _start_app fsearch
  _start_app insomnia
  _start_app keepassxc
  _start_guake
}


stbootdesktop "$@"
