#!/usr/bin/env bash

# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Purpose: jfilesync wrapper

myjfilesync () {

  chmod u+x "${MYOPT}/jfilesync/JFileSync.sh" 2>/dev/null

  if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
    (cd "${MYOPT:-$HOME/opt}"/jfilesync \
      && nohup ./JFileSync.sh "$@" \
      > "${DS_ENV_LOG:-$HOME/log}/JFileSync.log" \
      2>&1 \
      &)
  elif [[ "$(uname -a)" = *[Cc]ygwin* ]] ; then
    nohup "${MYOPT:-$HOME/opt}"/jfilesync/JFileSync.bat \
      "$(cygpath -w "$1")" \
      > "${DS_ENV_LOG:-$HOME/log}/JFileSync.log" \
      2>&1 \
      &
  fi
}

myjfilesync "$@"
