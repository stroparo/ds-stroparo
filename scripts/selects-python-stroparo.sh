#!/usr/bin/env bash

PROGNAME="selects-python-stroparo.sh"

# Pre-reqs: pipinstall.sh from Daily Shells at https://stroparo.github.io/ds

if !(uname -a | grep -i -q linux) ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: Only Linux is supported." 1>&2
  exit
fi


# Globals
TOOLS2="${DS_CONF:-${HOME}/.ds/conf}/packages/piplist-tools2"
TOOLS3="${DS_CONF:-${HOME}/.ds/conf}/packages/piplist-tools3"
VENVTOOLS2="tools27"
VENVTOOLS3="tools38"


echo "${PROGNAME:+$PROGNAME: }INFO: Python selects set 'stroparo' - starting..."

echo "${PROGNAME:+$PROGNAME: }INFO: Calling pipinstall.sh (ds) with list '${TOOLS3}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -v "$VENVTOOLS3" "${TOOLS3}"

echo "${PROGNAME:+$PROGNAME: }INFO: Calling pipinstall.sh (ds) with list '${TOOLS2}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -v "$VENVTOOLS2" "${TOOLS2}"

echo "${PROGNAME:+$PROGNAME: }COMPLETE"
echo
echo
