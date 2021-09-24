#!/usr/bin/env bash

export OPTS_DARK="--enable-features=WebUIDarkMode --force-dark-mode"

CHROME_CMD=google-chrome
if which google-chrome-stable >/dev/null 2>&1 ; then
	CHROME_CMD=google-chrome-stable
fi

if [ -n "${CHROME_UDD}" ] && [ ! -d "${CHROME_UDD}" ] ; then
  mkdir -p "${CHROME_UDD}"
fi

if which "${CHROME_CMD}" >/dev/null 2>&1 \
  && ! (ps -ef | grep -i -w "${CHROME_CMD:-google-chrome}" | grep -v grep)
then
  "${CHROME_CMD}" ${OPTS_DARK} ${CHROME_UDD:+--user-data-dir=${CHROME_UDD}} \
    &
  disown
fi
