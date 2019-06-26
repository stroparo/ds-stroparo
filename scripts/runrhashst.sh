#!/bin/bash

PROGNAME="runrhashst.sh"

echo
echo "${PROGNAME:+$PROGNAME: }INFO: Applying ds-stroparo's dotfiles configurations:" 1>&2
echo "${DOTFILES_SELECTS_ST}"
echo "${PROGNAME:+$PROGNAME: }INFO: Started..."
runrhash.sh ${DOTFILES_SELECTS_ST}
