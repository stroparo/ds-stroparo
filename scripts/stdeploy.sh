#!/usr/bin/env bash

# Author: Cristian Stroparo
# Licensed by the author's discretion.

PROGNAME=${0##*/}

. "$DS_HOME"/functions/gitfunctions.sh

_deploy_apps () {
  installanki.sh
  installdocker.sh
  installdropbox.sh
  installexa.sh
  installohmyzsh.sh
  installpowerfonts.sh

  # Home office:
  installcitrix.sh
}

_deploy_git () {

  which git >/dev/null 2>&1 || return 1

  deploygit "\
    'color.ui auto' \
    'core.autocrlf false' \
    'credential.helper \"cache --timeout=36000\"' \
    'diff.submodule log' \
    'push.default simple' \
    'push.recurseSubmodules check' \
    'sendpack.sideband false' \
    'status.submodulesummary 1'\
    " \
    || return 1

  git config --global --replace-all core.pager "less -F -X" \
    || return 1
}

_deploy_python () {

  addpystartup

  install-python-ubuntu1604.sh "$DS_CONF/pip"{2,3}"tools.lst"

  cat <<EOF
Commands to install Python 3.6.0 packages:
pyenv activate 3.6.0
pipinstall "${DS_CONF}/pip36.lst"
pyenv deactivate
EOF
}

_deploy_ruby () {
  install-ruby-ubuntu1604.sh "$DS_CONF/gem.lst" \
    || return 1
}

_custom_deploy () {

  typeset all=false

  if [ "$1" = '-a' ] ; then
    all=true
  fi

  if [ "$1" = '-h' ] || [ $# -eq 0 ] ; then
cat <<EOF
${PROGNAME} [arguments]

Items:
apps
git
python
ruby

Example:
${PROGNAME} apps git python
EOF
    return
  fi

  for item in "$@" ; do
    if ! eval "_deploy_${item}" ; then
      echo "WARN: There were failures deploying '$item'" 1>&2
    fi
  done

  echo 'INFO: Deploy complete ... restart the shell.' 1>&2
}

_custom_deploy "$@"
