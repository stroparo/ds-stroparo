#!/usr/bin/env bash

export OPTS_DARK="--enable-features=WebUIDarkMode --force-dark-mode"

if [ -n "${CHROME_UDD}" ] && [ ! -d "${CHROME_UDD}" ] ; then
  mkdir -p "${CHROME_UDD}"
fi

if which google-chrome >/dev/null 2>&1 \
  && ! (ps -ef | grep -i -w 'google-chrome' | grep -v grep)
then
  google-chrome ${OPTS_DARK} ${CHROME_UDD:+--user-data-dir=${CHROME_UDD}} \
    &
  disown
fi
