#!/usr/bin/env bash

# Daily Shells Stroparo extensions

# Purpose: inadyn wrapper

mydns () {
  sudo nohup inadyn > "${DS_ENV_LOG:-$HOME/log}"/inadyn.log 2>&1 &
}

mydns "$@"
