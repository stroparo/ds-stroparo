#!/usr/bin/env bash

# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Globals

PROGNAME="$(basename "${0:-stdeploy.sh}")"

DOTFILES_DIR="$HOME/dotfiles-master"
[ -d "$DEV/dotfiles" ] && DOTFILES_DIR="$DEV/dotfiles"

PKGS_GURU="dupeguru-se dupeguru-me dupeguru-pe moneyguru"
PKGS_REMMINA="remmina remmina-plugin-rdp remmina-plugin-vnc \
  libfreerdp-plugins-standard"

# #############################################################################
# Dependencies

if ! . "$DS_HOME"/functions/gitfunctions.sh ; then
  echo "FATAL: Could not source dependencies." 1>&2
  exit 1
fi

# #############################################################################
# Functions

_deploy_apps () {
  "$DOTFILES_DIR/installers/setupanki.sh"
  "$DOTFILES_DIR/installers/setupdropbox.sh"
  "$DOTFILES_DIR/installers/setupexa.sh"

  if egrep -i -q 'debian|ubuntu' /etc/*release* ; then

    # PPA stuff
    aptinstall.sh -r 'hsoft/ppa' $PKGS_GURU
    aptinstall.sh -r 'font-manager/staging' font-manager
    aptinstall.sh -r 'nathan-renniewaldock/qdirstat' qdirstat
    aptinstall.sh -r 'remmina-ppa-team/remmina-next' $PKGS_REMMINA
    aptinstall.sh -r 'webupd8team/y-ppa-manager' y-ppa-manager

    # VPN
    aptinstall.sh network-manager-openconnect network-manager-vpnc
  fi
}

_deploy_citrix () {
  "$DOTFILES_DIR/installers/setupcitrix.sh"
}

_deploy_devel () {
  "$DOTFILES_DIR/installers/setupdocker.sh"
  "$DOTFILES_DIR/installers/setupdocker-compose.sh"
  "$DOTFILES_DIR/installers/setupexa.sh"
  "$DOTFILES_DIR/installers/setupnerdfonts.sh"
  "$DOTFILES_DIR/installers/setupohmyzsh.sh"
  "$DOTFILES_DIR/installers/setupvim.sh"

  if egrep -i -q 'debian|ubuntu' /etc/*release* ; then

    # PPA stuff
    aptinstall.sh -r 'font-manager/staging' font-manager
    aptinstall.sh -r 'remmina-ppa-team/remmina-next' $PKGS_REMMINA
  fi
}

_deploy_nextcloud () {
  aptinstall.sh -r nextcloud-devs/client nextcloud-client
}

_deploy_python () {
  # TODO update when they are moved to DS_CONF back again
  typeset tools2="${DS_CONF}/packages/piplist-tools2"
  typeset tools3="${DS_CONF}/packages/piplist-tools3"
  typeset tools36="${DS_CONF}/packages/piplist3.6-tools3"

  # Speed up disabling prompt as it is going to be discontinued anyway:
  PYENV_PROMPT_DISABLE='export PYENV_VIRTUALENV_DISABLE_PROMPT=1'
  if ! grep -q "$PYENV_PROMPT_DISABLE" "$HOME"/.bashrc 2>/dev/null; then
    echo "$PYENV_PROMPT_DISABLE" >> "$HOME"/.bashrc
  fi
  if ! grep -q "$PYENV_PROMPT_DISABLE" "$HOME"/.zshrc 2>/dev/null; then
    echo "$PYENV_PROMPT_DISABLE" >> "$HOME"/.zshrc
  fi

  "$DOTFILES_DIR/installers/setuppython.sh" "$tools2" "$tools3"

  cat <<EOF
Commands to install Python 3.6.4 packages:
pyenv activate 3.6.4
pipinstall "$tools36"
pyenv deactivate
EOF
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
${PROGNAME} apps devel python
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
