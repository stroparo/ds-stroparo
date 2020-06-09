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


_start_flux () {
  # Display lighting following the sun at Curitiba, Brazil:
  if type flux >/dev/null 2>&1 && ! pgrep -fl flux; then
    flux -l -25 -g -49 -k 4700 & disown
  fi
}


_start_guake () {
  # Quake style terminal emulator:
  if type guake >/dev/null 2>&1 && ! pgrep -fl guake ; then
    guake & disown
  fi
}


stbootdesktop () {
  _start_flux
  _start_guake

  if _load_daily_shells ; then
    chromedark.sh
  fi
  codium
  keepass
}


stbootdesktop "$@"
