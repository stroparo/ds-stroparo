#!/usr/bin/env bash

# Daily Shells Stroparo extensions

myums () {
  nohup "${MYOPT:-$HOME/opt}/ums/UMS.sh" \
    > "${DS_ENV_LOG:-$HOME/log}/ums.log" \
    2>&1 \
    &
}

myums "$@"
