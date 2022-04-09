#!/usr/bin/env bash

myums () {
  nohup "${MYOPT:-$HOME/opt}/ums/UMS.sh" \
    > "${ZDRA_ENV_LOG:-$HOME/log}/ums.log" \
    2>&1 \
    &
}

myums "$@"
