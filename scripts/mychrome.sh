#!/usr/bin/env bash

if [ -n "${STUDD}" ] && [ ! -d "${STUDD}" ] ; then
  mkdir -p "${STUDD}"
fi

if which google-chrome >/dev/null 2>&1 \
  && ! (ps -ef | grep -i -w 'google-chrome' | grep -v grep)
then
  google-chrome ${STUDD:+--user-data-dir=${STUDD}} \
    --use-gl=desktop \
    &
  disown
fi
