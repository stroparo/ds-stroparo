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


_pyenv_load () {
  echo "${PROGNAME:+$PROGNAME: }INFO: Loading pyenv and virtualenvwrapper..."
  export PATH="${PYENV_ROOT:-$HOME/.pyenv}/bin:${PATH}"
  if command -v pyenv >/dev/null 2>&1 ; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    eval "$(grep 'VIRTUALENVWRAPPER_PYTHON=' ~/.bashrc)"
    eval "$(grep '^source.*virtualenvwrapper.sh$' ~/.bashrc)"
  fi
}


echo "${PROGNAME:+$PROGNAME: }INFO: Python selects installations ('stroparo' set) started..."

echo "${PROGNAME:+$PROGNAME: }INFO: Calling pipinstall.sh (ds) with list '${TOOLS3}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -v "$VENVTOOLS3" "${TOOLS3}"

echo "${PROGNAME:+$PROGNAME: }INFO: Calling pipinstall.sh (ds) with list '${TOOLS2}'..."
"${DS_HOME:-${HOME}/.ds}/scripts/pipinstall.sh" -v "$VENVTOOLS2" "${TOOLS2}"


# #############################################################################
echo "${PROGNAME:+$PROGNAME: }INFO: POST package installations setup..."

_pyenv_load

# Command completion for zsh:
if which zsh >/dev/null 2>&1 ; then
  if which poetry >/dev/null 2>&1 ; then
    poetry completions zsh > ~/.zfunc/_poetry
  fi
fi

# #############################################################################

echo "${PROGNAME:+$PROGNAME: }COMPLETE"
echo
echo
