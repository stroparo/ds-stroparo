#!/usr/bin/env bash

PROGNAME="syncvscode.sh"
_exit () { echo ; echo ; echo ; exit 0 ; }
_exiterr () { echo "$2" 1>&2 ; echo 1>&2 ; echo 1>&2 ; exit "$1" ; }

SRC_CONFIG_DIR="${DEV}/dotfiles/config/vscode"
if [ ! -d "$SRC_CONFIG_DIR" ] ; then _exiterr 1 "${PROGNAME}: FATAL: No dir '${SRC_CONFIG_DIR}'." ; fi

export EDITOR_COMMAND="code"
if ! which ${EDITOR_COMMAND} >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: ${EDITOR_COMMAND} not available." ; fi

: ${DIFFPROG:=meld}
if ! which "${DIFFPROG}" >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: missing diff program '${DIFFPROG}' in PATH." ; fi

# Global CODE_USER_DIR:
if which cygpath >/dev/null 2>&1 ; then CODE_USER_DIR="$(cygpath "${USERPROFILE}" 2>/dev/null)/AppData/Roaming/Code/User" ; fi
if [[ "$(uname -a)" = *[Ll]inux* ]] ; then CODE_USER_DIR="${HOME}/.config/code/User" ; fi
mkdir -p "${CODE_USER_DIR}"
if [ ! -d "${CODE_USER_DIR}" ] ; then _exit "${PROGNAME}: SKIP: no dir '$CODE_USER_DIR'." ; fi


# Diff:
if which cygwin >/dev/null 2>&1 ; then
  SRC_CONFIG_DIR="$(cygpath -w "${SRC_CONFIG_DIR}" | sed -e 's#\\#\\\\#g')"
  CODE_USER_DIR="$(cygpath -w "${CODE_USER_DIR}" | sed -e 's#\\#\\\\#g')"
fi
"${DIFFPROG}" "${SRC_CONFIG_DIR}" "${CODE_USER_DIR}" &
disown

# Other diff scripts
for script in ${DS_HOME:-${HOME}/.ds}/scripts/syncvscode*sh ; do
  if [[ ${script} = *${PROGNAME} ]] ; then continue ; fi
  "${script}"
done
