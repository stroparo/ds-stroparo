#!/usr/bin/env bash

# Purpose: inadyn wrapper

mydns () {
  sudo nohup inadyn > "${ZDRA_ENV_LOG:-$HOME/log}"/inadyn.log 2>&1 &
}

mydns "$@"
