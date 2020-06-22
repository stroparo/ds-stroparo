#!/usr/bin/env bash
if ! (ps -ef | grep -i -w 'google-chrome' | grep -v grep) ; then
  google-chrome \
    --enable-features=WebUIDarkMode \
    --force-dark-mode \
    &
  disown
fi
