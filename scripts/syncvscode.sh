#!/usr/bin/env bash

PROGNAME="syncvscode.sh"

# Requirements:
# * ds (Daily Shells) at https://stroparo.github.io/ds - MOUNTS_PREFIX global etc.
# * ds-stroparo plugin

SRC_CONFIG_DIR="${DEV}/dotfiles/config/vscode"
: ${DIFFPROG:=meld}
if ! which ${DIFFPROG} >/dev/null 2>&1 ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: the diff program '${DIFFPROG}' is not available." 1>&2
  exit
fi


_sync_vscode () {
  typeset user_dir="${HOME}/.vscode/user" # TODO check and fix

  if (uname -a | egrep -i -q "mingw|msys|win32|windows") ; then
    typeset SRC_CONFIG_DIR="$(cygpath -w "${DEV}/dotfiles/config/vscode" | sed -e 's#\\#\\\\#g')"
    typeset user_dir="$(cygpath -w "${MOUNTS_PREFIX}/c/Users/`whoami`/AppData/Roaming/Code/User" | sed -e 's#\\#\\\\#g')"
  fi
  if (uname -a | egrep -i -q "cygwin") ; then
    typeset SRC_CONFIG_DIR="$(cygpath -w "${DEV}/dotfiles/config/vscode" | sed -e 's#\\#\\\\#g')"
    typeset user_dir="/Users/`whoami`/AppData/Roaming/Code/User"
  fi
  "${DIFFPROG}" "${SRC_CONFIG_DIR}" "${user_dir}" &
  disown
}


_sync_vscode_etc () {
  for script in ${DS_HOME:-${HOME}/.ds}/scripts/syncvscode*sh ; do
    if [[ ${script} = *${PROGNAME} ]] ; then continue ; fi
    "${script}"
  done
}


_sync_vscode "$@"
_sync_vscode_etc
