#!/usr/bin/env bash

PROGNAME="syncdifffsearch.sh"

_exit () { echo "$1" ; echo ; echo ; exit 0 ; }
_exiterr () { echo "$2" 1>&2 ; echo 1>&2 ; echo 1>&2 ; exit "$1" ; }

# Globals
: ${DIFFPROG:=meld}
if ! which "${DIFFPROG}" >/dev/null 2>&1 ; then _exit "${PROGNAME}: SKIP: missing diff program '${DIFFPROG}' in PATH." ; fi


echo "${PROGNAME}: INFO: Diffing:"
for path in {$HOME/.config,${DEV}/dotfiles/dotfiles/config}/fsearch/fsearch.conf ; do
  echo "${PROGNAME}: INFO: $path"
done
"${DIFFPROG}" {$HOME/.config,${DEV}/dotfiles/dotfiles/config}/fsearch/fsearch.conf

echo "${PROGNAME}: COMPLETE"
echo
echo
