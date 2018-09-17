#!/usr/bin/env bash

# Requirements:
# * ds (Daily Shells) at https://stroparo.github.io/ds - MOUNTS_PREFIX global etc.
# * ds-stroparo plugin

# Globals

PROGNAME="syncvscode.sh"

_sync_vscode () {
  typeset diffprog="${DIFFPROG:-meld}"
  typeset vscode_dotfiles_dir="${DEV}/dotfiles/code"
  typeset vscode_user_dir="${HOME}/.code/user" # TODO check and fix

  if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
    typeset vscode_user_dir="${MOUNTS_PREFIX}/c/Users/`whoami`/AppData/Roaming/Code/User"
  fi
  "${diffprog}" "${vscode_dotfiles_dir}" "${vscode_user_dir}"
}

_sync_vscode "$@"
