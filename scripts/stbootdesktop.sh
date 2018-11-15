#!/usr/bin/env bash

# Daily Shells Stroparo extensions

# Purpose: Boot desktop applications

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
}

stbootdesktop "$@"
