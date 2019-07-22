#!/bin/bash

PROGNAME="st-conf-dotfiles.sh"

echo
echo "${PROGNAME:+$PROGNAME: }INFO: Applying dotfiles from stroparo's selects:" 1>&2
echo "${DOTFILES_SELECTS_ST}"
echo "${PROGNAME:+$PROGNAME: }INFO: Started..."
runrhash.sh ${DOTFILES_SELECTS_ST}

echo "${PROGNAME:+$PROGNAME: }INFO: Applying DS' dsconfsgit.sh:" 1>&2
dsconfsgit.sh

echo "${PROGNAME:+$PROGNAME: }INFO: Finished." 1>&2
