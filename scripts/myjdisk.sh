#!/usr/bin/env bash

# Daily Shells Stroparo extensions

# Purpose: jdiskreport wrapper

myjdisk () {
  (cd "${MYOPT:-$HOME/opt}"/jdiskreport && nohup java -jar jdiskreport-1.4.0.jar "$@" \
    > "${DS_ENV_LOG:-$HOME/log}"/jdiskreport.log \
    2>&1 \
    &)
}

myjdisk "$@"
