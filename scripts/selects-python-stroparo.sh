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

_print_header () {
  echo "################################################################################"
  echo "$@"
  echo "################################################################################"
}

# #############################################################################
# Main

if ! (uname -a | grep -i -q linux) ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: Not in Linux." 1>&2
  exit
fi

_print_header "Python custom package selects - '${TOOLSGLOBAL}'"
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" "${TOOLSGLOBAL}"

_print_header "Python custom package selects - '${TOOLS3}'"
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -e tools3 "${TOOLS3}"

_print_header "Python custom package selects - '${TOOLS2}'"
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -e tools2 "${TOOLS2}"

# _print_header "Pipsi isolated venvs for each installed script"
# curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
