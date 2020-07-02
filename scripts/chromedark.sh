#!/usr/bin/env bash

if [ -n "${CHROME_USER_DATA_DIR}" ] && [ ! -d "${CHROME_USER_DATA_DIR}" ] ; then
  mkdir -p "${CHROME_USER_DATA_DIR}"
fi

if ! (ps -ef | grep -i -w 'google-chrome' | grep -v grep) ; then
  google-chrome ${CHROME_USER_DATA_DIR:+--user-data-dir=${CHROME_USER_DATA_DIR}} \
    --enable-features=WebUIDarkMode \
    --force-dark-mode \
    &
  disown
fi
