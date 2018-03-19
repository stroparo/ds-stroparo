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

# System installers
export APTPROG=apt-get; which apt >/dev/null 2>&1 && export APTPROG=apt
export RPMPROG=yum; which dnf >/dev/null 2>&1 && export RPMPROG=dnf
export RPMGROUP="yum groupinstall"; which dnf >/dev/null 2>&1 && export RPMGROUP="dnf group install"
export INSTPROG="$APTPROG"; which "$RPMPROG" >/dev/null 2>&1 && export INSTPROG="$RPMPROG"

# #############################################################################
# Helpers

userconfirm () {
  # Info: Ask a question and yield success if user responded [yY]*

  typeset confirm
  typeset result=1

  echo ${BASH_VERSION:+-e} "$@" "[y/N] \c"
  read confirm
  if [[ $confirm = [yY]* ]] ; then return 0 ; fi
  return 1
}

# #############################################################################
# Prep dependencies

if ! . "$DS_HOME"/functions/gitfunctions.sh ; then
  echo "FATAL: Could not source dependencies." 1>&2
  exit 1
fi

# Dotfiles provisioning:
if [ ! -d "$DOTFILES_DIR" ] ; then
  curl -LSfs -o "$HOME"/.dotfiles.zip \
    https://github.com/stroparo/dotfiles/archive/master.zip \
    && unzip -o "$HOME"/.dotfiles.zip -d "$HOME"
fi
if ! which setupvim.sh >/dev/null 2>&1 ; then
  pathmunge -x "$HOME/dotfiles-master/installers"
fi
if ! (echo "$PATH" | grep -i dotfiles) || ! which setupvim.sh >/dev/null 2>&1 ; then
  echo "${PROGNAME:+$PROGNAME: }FATAL: dotfiles directory unreachable in PATH ($PATH)." 1>&2
  exit 1
fi

# #############################################################################
# Applications

# Oneliners:
_deploy_nextcloud () { aptinstall.sh -r nextcloud-devs/client nextcloud-client ; }

_deploy_fonts () {
  "setupfonts-el.sh"
  "setupnerdfonts.sh"

  if egrep -i -q 'ubuntu' /etc/*release ; then
    aptinstall.sh -r 'font-manager/staging' font-manager
  fi
}

_deploy_ppa () {

  if egrep -i -q 'ubuntu' /etc/*release ; then

    # PPA stuff
    aptinstall.sh -r 'hsoft/ppa' $PKGS_GURU
    aptinstall.sh -r 'nathan-renniewaldock/qdirstat' qdirstat
    aptinstall.sh -r 'webupd8team/y-ppa-manager' y-ppa-manager
  fi
}

_deploy_rdpclient () {
  if egrep -i -q 'ubuntu' /etc/*release ; then
    aptinstall.sh -r 'remmina-ppa-team/remmina-next' $PKGS_REMMINA
  fi
}

_deploy_vpn () {
  if egrep -i -q 'debian|ubuntu' /etc/*release ; then
    aptinstall.sh network-manager-openconnect network-manager-vpnc
  fi
 }

# #############################################################################
# Development

# Oneliners:
_deploy_vim () { userconfirm "Compile Vim latest?" && "setupvim.sh" ; }

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

  "setuppython.sh" "$tools2" "$tools3"

  cat <<EOF
Commands to install Python 3.6.4 packages:
pyenv activate 3.6.4
pipinstall "$tools36"
pyenv deactivate
EOF
}

# #############################################################################
# Wrappers

_deploy_devel () {
  _deploy_python
  _deploy_vim
  "setupdocker.sh"
  "setupdocker-compose.sh"
  "setupexa.sh"
}

_deploy_develgui () {
  _deploy_fonts
  userconfirm 'Setup Atom?'               && "setupatom.sh"
  userconfirm 'Setup Sublime-Text?'       && "setupsubl.sh"
  userconfirm 'Setup Visual Studio Code?' && "setupvscode.sh"

  # Etcetera:
  sudo $INSTPROG install -y guake
  sudo $INSTPROG install -y meld
}

_deploy_corp () {
  _deploy_devel
}

_deploy_corpgui () {
  "setupxfce.sh"
  "setuprdp.sh"
  _deploy_develgui
}

_deploy_pc () {
  "setupxfce.sh"
  _deploy_devel
  _deploy_develgui

  # Etcetera:
  _deploy_ppa
  "debselects-desktop.sh"
  "rpmselects-desktop.sh"
  "setupanki.sh"
  "setupcitrix.sh"
  "setupdropbox.sh"
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
