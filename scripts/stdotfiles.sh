#!/usr/bin/env bash

PROGNAME="${0##*/}"

export DOTFILES_SELECTS="${DOTFILES_SELECTS} alias dotfiles git sshmodes"

echo
echo "${PROGNAME:+$PROGNAME: }INFO: Executing dotfiles selects..." 1>&2
echo "${DOTFILES_SELECTS}"
echo "${PROGNAME:+$PROGNAME: }INFO: Started..."
runrhash.sh ${DOTFILES_SELECTS}

echo "${PROGNAME:+$PROGNAME: }INFO: COMPLETE" 1>&2
