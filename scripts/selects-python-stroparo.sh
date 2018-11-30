#!/usr/bin/env bash

# Pre-reqs: pipinstall.sh from Daily Shells at https://stroparo.github.io/ds

TOOLS2="${DS_CONF}/packages/piplist-tools2"
TOOLS3="${DS_CONF}/packages/piplist-tools3"
TOOLSGLOBAL="${DS_CONF}/packages/piplist-global"


_print_header () {
  echo "################################################################################"
  echo "$@"
  echo "################################################################################"
}


_print_header "Python custom package selects - '$TOOLSGLOBAL'"
pipinstall.sh "$TOOLSGLOBAL"

_print_header "Python custom package selects - '$TOOLS3'"
pipinstall.sh -e tools3 "$TOOLS3"

_print_header "Python custom package selects - '$TOOLS2'"
pipinstall.sh -e tools2 "$TOOLS2"

# _print_header "Pipsi isolated venvs for each installed script"
# curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
