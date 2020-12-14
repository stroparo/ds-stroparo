#!/usr/bin/env bash

PROGNAME="syncdiffgtk.sh"

_exit () { echo "$1" ; echo ; echo ; exit 0 ; }
_exiterr () { echo "$2" 1>&2 ; echo 1>&2 ; echo 1>&2 ; exit "$1" ; }

# #############################################################################
# Globals

: ${DIFFPROG:=meld}
if ! which "${DIFFPROG}" >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: missing diff program '${DIFFPROG}' in PATH." ; fi

# #############################################################################
# Sync / diff

echo "Diffing:"
echo "${HOME}/.config/gtk-3.0/bookmarks"
echo "${DEV}/dotfiles/dotfiles/config/gtk-3.0/bookmarks"
"${DIFFPROG}" \
  "${HOME}/.config/gtk-3.0/bookmarks" \
  "${DEV}/dotfiles/dotfiles/config/gtk-3.0/bookmarks"

# #############################################################################
