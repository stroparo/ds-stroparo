#!/usr/bin/env bash

PROGNAME="syncdiffvsc.sh"

_exit () { echo "$1" ; echo ; echo ; exit 0 ; }
_exiterr () { echo "$2" 1>&2 ; echo 1>&2 ; echo 1>&2 ; exit "$1" ; }

# #############################################################################
# Globals

: ${DIFFPROG:=meld}
if ! which "${DIFFPROG}" >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: missing diff program '${DIFFPROG}' in PATH." ; fi

export EDITOR_COMMAND="code"
export CONF_DIR_BASENAME="Code"
SRC_CONFIG_DIR="${DEV}/dotfiles/config/vsc"

if ! which ${EDITOR_COMMAND} >/dev/null 2>&1 && which codium >/dev/null 2>&1 ; then
  export EDITOR_COMMAND="codium"
  export CONF_DIR_BASENAME="VSCodium"
fi
if ! which ${EDITOR_COMMAND} >/dev/null 2>&1 ; then
  _exit "${PROGNAME}: SKIP: ${EDITOR_COMMAND} not available."
fi

if [ ! -d "${SRC_CONFIG_DIR}" ] ; then _exiterr 1 "${PROGNAME}: FATAL: No dir '${SRC_CONFIG_DIR}'." ; fi

# CODE_USER_DIR global:
if which cygpath >/dev/null 2>&1 ; then CODE_USER_DIR="$(cygpath "${USERPROFILE}" 2>/dev/null)/AppData/Roaming/${CONF_DIR_BASENAME}/User" ; fi
if [[ "$(uname -a)" = *[Ll]inux* ]] ; then CODE_USER_DIR="${HOME}/.config/${CONF_DIR_BASENAME}/User" ; fi
mkdir -p "${CODE_USER_DIR}"
if [ ! -d "${CODE_USER_DIR}" ] ; then _exit "${PROGNAME}: SKIP: no dir '${CODE_USER_DIR}'." ; fi

# #############################################################################
# Sync / diff

if which cygwin >/dev/null 2>&1 ; then
  SRC_CONFIG_DIR="$(cygpath -w "${SRC_CONFIG_DIR}" | sed -e 's#\\#\\\\#g')"
  CODE_USER_DIR="$(cygpath -w "${CODE_USER_DIR}" | sed -e 's#\\#\\\\#g')"
fi
echo "${PROGNAME}: INFO: Diffing:"
echo "${PROGNAME}: INFO: ${SRC_CONFIG_DIR}"
echo "${PROGNAME}: INFO: ${CODE_USER_DIR}"
"${DIFFPROG}" "${SRC_CONFIG_DIR}" "${CODE_USER_DIR}"

echo "${PROGNAME}: COMPLETE"
echo
echo
