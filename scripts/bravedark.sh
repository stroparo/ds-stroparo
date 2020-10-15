#!/usr/bin/env bash

if [ -n "${BRAVE_USER_DATA_DIR}" ] && [ ! -d "${BRAVE_USER_DATA_DIR}" ] ; then
  mkdir -p "${BRAVE_USER_DATA_DIR}"
fi

if ! (ps -ef | grep -i -w 'brave' | grep -v grep) ; then
  brave ${BRAVE_USER_DATA_DIR:+--user-data-dir=${BRAVE_USER_DATA_DIR}} \
    --enable-features=WebUIDarkMode \
    --force-dark-mode \
    &
  disown
fi
