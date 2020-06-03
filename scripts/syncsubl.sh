#!/usr/bin/env bash

PROGNAME="syncsubl.sh"
_exit () { echo "$1" ; echo ; echo ; exit 0 ; }
_exiterr () { echo "$2" 1>&2 ; echo 1>&2 ; echo 1>&2 ; exit "$1" ; }

SRC_CONFIG_DIR="${DEV}/dotfiles/config/subl"
if [ ! -d "$SRC_CONFIG_DIR" ] ; then _exiterr 1 "${PROGNAME}: FATAL: No dir '${SRC_CONFIG_DIR}'." ; fi

export EDITOR_COMMAND="subl"
if ! which ${EDITOR_COMMAND} >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: ${EDITOR_COMMAND} not available." ; fi

: ${DIFFPROG:=meld}
if ! which ${DIFFPROG} >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: missing diff program '${DIFFPROG}' in PATH." ; fi

# Global SUBL_USER:
SUBL_USER="$HOME/.config/sublime-text-3/Packages/User"
SUBL_WIN="$(cygpath "$USERPROFILE" 2>/dev/null)/AppData/Roaming/Sublime Text 3"
SUBL_WIN_OPT="$(cygpath "$USERPROFILE" 2>/dev/null)/opt/subl"
if [ -d "${SUBL_WIN}" ] ; then SUBL_USER="${SUBL_WIN}/Packages/User" ; fi
if [ -d "${SUBL_WIN_OPT}" ] ; then SUBL_USER="${SUBL_WIN_OPT}/Data/Packages/User" ; fi
mkdir -p "${SUBL_USER}"
if [ ! -d "$SUBL_USER" ] ; then _exiterr 1 "${PROGNAME}: FATAL: Could not create SUBL_USER dir '$SUBL_USER'." ; fi


# Diff:
if which cygwin >/dev/null 2>&1 ; then
  SRC_CONFIG_DIR="$(cygpath -w "${SRC_CONFIG_DIR}" | sed -e 's#\\#\\\\#g')"
  SUBL_USER="$(cygpath -w "${SUBL_USER}" | sed -e 's#\\#\\\\#g')"
fi
"${DIFFPROG}" "${SRC_CONFIG_DIR}" "${SUBL_USER}" &
disown
