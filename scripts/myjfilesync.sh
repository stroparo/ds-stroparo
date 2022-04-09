#!/usr/bin/env bash

# Purpose: jfilesync wrapper

myjfilesync () {

  chmod -v u+x "${MYOPT}/jfilesync/JFileSync.sh" 2>/dev/null

  if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
    (cd "${MYOPT:-$HOME/opt}"/jfilesync \
      && nohup ./JFileSync.sh "$@" \
      > "${ZDRA_ENV_LOG:-$HOME/log}/JFileSync.log" \
      2>&1 \
      &)
  elif (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
    nohup "${MYOPT:-$HOME/opt}"/jfilesync/JFileSync.bat \
      "$(cygpath -w "$1")" \
      > "${ZDRA_ENV_LOG:-$HOME/log}/JFileSync.log" \
      2>&1 \
      &
  fi
}

myjfilesync "$@"
