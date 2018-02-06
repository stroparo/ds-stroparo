#!/usr/bin/env bash

# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

PROGNAME=${0##*/}

if ! . "$DS_HOME"/functions/gitfunctions.sh ; then
  echo "FATAL: Could not source dependencies." 1>&2
  exit 1
fi

# #############################################################################
# Functions

_deploy_apps () {
  setupanki.sh
  setupdocker.sh
  setupdocker-compose.sh
  setupdropbox.sh
  setupexa.sh
  setupnerdfonts.sh
  setupohmyzsh.sh

  # APT
  aptinstallpackages.sh -r hsoft/ppa \
    dupeguru-se dupeguru-me dupeguru-pe moneyguru pdfmasher

  aptinstallpackages.sh -r font-manager/staging \
    font-manager

  aptinstallpackages.sh -r nathan-renniewaldock/qdirstat \
    qdirstat

  aptinstallpackages.sh -r webupd8team/y-ppa-manager \
    y-ppa-manager
}

_deploy_git () {

  which git >/dev/null 2>&1 \
    || (sudo apt update && sudo apt install -y 'git-core') \
    || (sudo yum install -y git)
  which git >/dev/null 2>&1 || return 1

  typeset gitcygwinfile
  if (uname -a | grep -i -q cygwin) ; then

    gitcygwinfile="$(cygpath "$USERPROFILE")/.gitconfig"
    touch "$gitcygwinfile"

    [ -n "$MYEMAIL" ] && gitset -f "$gitcygwinfile" -e "$MYEMAIL"
    [ -n "$MYSIGN" ] && gitset -f "$gitcygwifile" -n "$MYSIGN"
  fi

  [ -n "$MYEMAIL" ] && gitset -e "$MYEMAIL"
  [ -n "$MYSIGN" ] && gitset -n "$MYSIGN"

  while read key value ; do

    gitset -r "$key" "$value"

    if (uname -a | grep -i -q cygwin) ; then
      gitset -r -f "$gitcygwinfile" "$key" "$value"
    fi

  done <<EOF
core.pager        less -F -X
credential.helper cache --timeout=36000
color.ui          auto
core.autocrlf     false
diff.submodule    log
push.default      simple
push.recurseSubmodules  check
sendpack.sideband false
status.submodulesummary 1
EOF
}

_deploy_nextcloud () {
  aptinstallpackages.sh -r nextcloud-devs/client nextcloud-client
}

_deploy_python () {
  # TODO update when they are moved to DS_CONF back again
  typeset tools2="${DEV}/dotfiles/custom/piplist-tools2"
  typeset tools3="${DEV}/dotfiles/custom/piplist-tools3"
  typeset tools36="${DEV}/dotfiles/custom/piplist3.6-tools3"

  # Speed up disabling prompt as it is going to be discontinued anyway:
  appendunique 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1' \
    "$HOME"/.bashrc "$HOME"/.zshrc

  setuppython.sh "$tools2" "$tools3"

  cat <<EOF
Commands to install Python 3.6.4 packages:
pyenv activate 3.6.4
pipinstall "$tools36"
pyenv deactivate
EOF
}

_deploy_rdp () {
  aptinstallpackages.sh -r remmina-ppa-team/remmina-next \
    remmina remmina-plugin-rdp remmina-plugin-vnc libfreerdp-plugins-standard
}

_deploy_ruby () {
  setupruby-ubuntu.sh "$DS_CONF/gem.lst"
}

# #############################################################################
# Main function

stdeploy () {

  if [ "$1" = '-h' ] || [ $# -eq 0 ] ; then
cat <<EOF
${PROGNAME} [item [item ...]]

Available items:
$(grep "_deploy_[a-z]* " "$(which "$PROGNAME")" \
  | sed -e 's/_deploy_//' -e 's/ .*$//')

Example:
${PROGNAME} apps git python
EOF
    return
  fi

  for item in "$@" ; do

    echo ${BASH_VERSION:+-e} "\n==> Deploying '${item}'..."

    if ! eval "_deploy_${item}" ; then
      echo "WARN: There were failures deploying '${item}'" 1>&2
    fi
  done

  echo 'INFO: Deploy complete ... restart the shell.' 1>&2
}

# #############################################################################
# Main

stdeploy "$@"
