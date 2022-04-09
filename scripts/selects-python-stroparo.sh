#!/usr/bin/env bash

PROGNAME="selects-python-stroparo.sh"

# Pre-reqs: pipinstall.sh from https://stroparo.github.io/sidra

if !(uname -a | grep -i -q linux) ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: Only Linux is supported." 1>&2
  exit
fi


# Globals
PIPLIST_TOOLS3_FILE="${ZDRA_CONF:-${HOME}/.zdra/conf}/packages/piplist-tools3"
VENVTOOLS3="tools$(python3 --version | egrep -o '[0-9]+[.][0-9]+' | tr -d .)"


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

echo "${PROGNAME:+$PROGNAME: }INFO: Calling pipinstall.sh (ds) with list '${PIPLIST_TOOLS3_FILE}'..."
"${ZDRA_HOME:-${HOME}/.zdra}/scripts/pipinstall.sh" -v "$VENVTOOLS3" "${PIPLIST_TOOLS3_FILE}"


# #############################################################################
echo "${PROGNAME:+$PROGNAME: }INFO: POST package installations setup..."

_pyenv_load

# Command completion for zsh:
if which zsh >/dev/null 2>&1 ; then
  mkdir -p ~/.zfunc >/dev/null 2>&1
  if which poetry >/dev/null 2>&1 ; then
    poetry completions zsh > ~/.zfunc/_poetry
  fi
fi

# #############################################################################

echo "${PROGNAME:+$PROGNAME: }COMPLETE"
echo
echo
exit
