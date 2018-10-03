#!/usr/bin/env bash

PROGNAME="syncvscode.sh"

# Requirements:
# * ds (Daily Shells) at https://stroparo.github.io/ds - MOUNTS_PREFIX global etc.
# * ds-stroparo plugin

_sync_vscode () {
  typeset diffprog="${DIFFPROG:-meld}"
  typeset vscode_dotfiles_dir="${DEV}/dotfiles/code"
  typeset vscode_user_dir="${HOME}/.code/user" # TODO check and fix

  if (uname -a | egrep -i -q "mingw|msys|win32|windows") ; then
    typeset vscode_dotfiles_dir="$(cygpath -w "${DEV}/dotfiles/code" | sed -e 's#\\#\\\\#g')"
    typeset vscode_user_dir="$(cygpath -w "${MOUNTS_PREFIX}/c/Users/`whoami`/AppData/Roaming/Code/User" | sed -e 's#\\#\\\\#g')"
  fi
  if (uname -a | egrep -i -q "cygwin") ; then
    typeset vscode_dotfiles_dir="$(cygpath -w "${DEV}/dotfiles/code" | sed -e 's#\\#\\\\#g')"
    typeset vscode_user_dir="/Users/`whoami`/AppData/Roaming/Code/User"
  fi
  "${diffprog}" "${vscode_dotfiles_dir}" "${vscode_user_dir}"
}

_sync_vscode "$@"
