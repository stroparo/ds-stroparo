#!/usr/bin/env bash

PROGNAME="syncvscodium.sh"
_exit () { echo "$1" ; echo ; echo ; exit 0 ; }
_exiterr () { echo "$2" 1>&2 ; echo 1>&2 ; echo 1>&2 ; exit "$1" ; }

SRC_CONFIG_DIR="${DEV}/dotfiles/config/vscodium"
if [ ! -d "$SRC_CONFIG_DIR" ] ; then _exiterr 1 "${PROGNAME}: FATAL: No dir '${SRC_CONFIG_DIR}'." ; fi

export EDITOR_COMMAND="codium"
if ! which ${EDITOR_COMMAND} >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: ${EDITOR_COMMAND} not available." ; fi

: ${DIFFPROG:=meld}
if ! which "${DIFFPROG}" >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: missing diff program '${DIFFPROG}' in PATH." ; fi

# Global CODE_USER_DIR:
if which cygpath >/dev/null 2>&1 ; then CODE_USER_DIR="$(cygpath "${USERPROFILE}" 2>/dev/null)/AppData/Roaming/VSCodium/User" ; fi
if [[ "$(uname -a)" = *[Ll]inux* ]] ; then CODE_USER_DIR="${HOME}/.config/VSCodium/User" ; fi
mkdir -p "${CODE_USER_DIR}"
if [ ! -d "${CODE_USER_DIR}" ] ; then _exit "${PROGNAME}: SKIP: no dir '$CODE_USER_DIR'." ; fi


# Diff:
if which cygwin >/dev/null 2>&1 ; then
  SRC_CONFIG_DIR="$(cygpath -w "${SRC_CONFIG_DIR}" | sed -e 's#\\#\\\\#g')"
  CODE_USER_DIR="$(cygpath -w "${CODE_USER_DIR}" | sed -e 's#\\#\\\\#g')"
fi
"${DIFFPROG}" "${SRC_CONFIG_DIR}" "${user_dir}" &
disown

# Other diff scripts
for script in ${DS_HOME:-${HOME}/.ds}/scripts/syncvscodium*sh ; do
  if [[ ${script} = *${PROGNAME} ]] ; then continue ; fi
  "${script}"
done
