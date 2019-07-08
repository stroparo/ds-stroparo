#!/usr/bin/env bash

PROGNAME="selects-python-stroparo.sh"

# Pre-reqs: pipinstall.sh from Daily Shells at https://stroparo.github.io/ds

# #############################################################################
# Globals

TOOLS2="${DS_CONF}/packages/piplist-tools2"
TOOLS3="${DS_CONF}/packages/piplist-tools3"
TOOLSGLOBAL="${DS_CONF}/packages/piplist-global"

# #############################################################################
# Functions

_end_bar () { echo "////////////////////////////////////////////////////////////////////////////////" ; }

_print_header () {
  echo "################################################################################"
  echo "$@"
}

# #############################################################################
# Main

_print_header "Python selects by Stroparo - starting..."

# Check Linux:
if !(uname -a | grep -i -q linux) ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: Only Linux is supported." 1>&2
  _end_bar
  exit
fi

_print_header "${PROGNAME:+$PROGNAME: }Calling pipinstall.sh (ds) with list '${TOOLSGLOBAL}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" "${TOOLSGLOBAL}"
_end_bar

_print_header "${PROGNAME:+$PROGNAME: }Calling pipinstall.sh (ds) with list '${TOOLS3}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -e tools3 "${TOOLS3}"
_end_bar

_print_header "${PROGNAME:+$PROGNAME: }Calling pipinstall.sh (ds) with list '${TOOLS2}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -e tools2 "${TOOLS2}"
_end_bar

# _print_header "${PROGNAME:+$PROGNAME: }Pipsi isolated venvs for each installed script"
# curl ${DLOPTEXTRA} https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
# _end_bar

echo "${PROGNAME:+$PROGNAME: }COMPLETE"
_end_bar

