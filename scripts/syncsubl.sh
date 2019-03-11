#!/usr/bin/env bash

PROGNAME="syncsubl.sh"

SRC_CONFIG_DIR="${DEV}/dotfiles/config/subl"
: ${DIFFPROG:=meld}
if ! which ${DIFFPROG} >/dev/null 2>&1 ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: the diff program '${DIFFPROG}' is not available." 1>&2
  exit
fi

# #############################################################################
# Prep User PATH

if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then

  SUBL_WIN="$(cygpath "$USERPROFILE")"'/AppData/Roaming/Sublime Text 3'

  if [ -d "${SUBL_WIN}" ] ; then
    SUBL_USER="${SUBL_WIN}/Packages/User"
  fi

  if [ -d "$(cygpath "$USERPROFILE")/opt/subl" ] ; then
    SUBL_USER="$(cygpath "$USERPROFILE")/opt/subl/Data/Packages/User"
  elif [ -d "/c/opt/subl" ] ; then
    SUBL_USER="/c/opt/subl/Data/Packages/User"
  elif [ -d "/cygdrive/c/opt/subl" ] ; then
    SUBL_USER="/cygdrive/c/opt/subl/Data/Packages/User"
  fi
elif [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  SUBL_USER="$HOME/.config/sublime-text-3/Packages/User"
fi

if [ ! -d "$SUBL_USER" ] ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: No SUBL_USER dir ('$SUBL_USER')." 1>&2
  exit
fi

# #############################################################################


_sync_subl () {
  typeset user_dir="${SUBL_USER}"

  if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
    typeset SRC_CONFIG_DIR="$(cygpath -w "${SRC_CONFIG_DIR}" | sed -e 's#\\#\\\\#g')"
  fi
  "${DIFFPROG}" "${SRC_CONFIG_DIR}" "${user_dir}" &
  disown
}


_sync_subl "$@"
