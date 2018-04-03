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

_user_confirm () {
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
# Basic deployments

# Oneliners:
_deploy_nextcloud () { aptinstall.sh -r nextcloud-devs/client nextcloud-client ; }
_deploy_vim () { _user_confirm "Compile Vim latest?" && "setupvim.sh" ; }

_deploy_baseguiel7 () {
  egrep -i -q '(centos|oracle|red *hat).* 7' /etc/*release || return
  # Fonts
  sudo yum install -y dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts google-crosextra-caladea-fonts google-crosextra-carlito-fonts liberation-mono-fonts liberation-sans-fonts liberation-serif-fonts open-sans-fonts overpass-fonts ucs-miscfixed-fonts
  # GNOME
  sudo yum install -y NetworkManager-libreswan-gnome PackageKit-command-not-found PackageKit-gtk3-module avahi caribou caribou-gtk2-module caribou-gtk3-module control-center evince file-roller file-roller-nautilus firstboot gdm gnome-boxes gnome-classic-session gnome-clocks gnome-color-manager gnome-font-viewer gnome-getting-started-docs gnome-icon-theme-extras gnome-icon-theme-symbolic gnome-initial-setup gnome-packagekit gnome-packagekit-updater gnome-screenshot gnome-session gnome-session-xsession gnome-settings-daemon gnome-shell gnome-software gnome-system-log gnome-system-monitor gnome-themes-standard gnome-tweak-tool gnome-user-docs gvfs-afp gvfs-goa libcanberra-gtk2 libcanberra-gtk3 libproxy-mozjs librsvg2 libsane-hpaio metacity mousetweaks rhn-setup-gnome sane-backends-drivers-scanners xdg-desktop-portal-gtk ibus-chewing ibus-hangul ibus-kkc ibus-libpinyin ibus-m17n ibus-rawcode ibus-sayura ibus-table ibus-table-chinese m17n-contrib m17n-db
  # MATE
  sudo yum install -y NetworkManager-l2tp NetworkManager-openconnect NetworkManager-openvpn NetworkManager-pptp NetworkManager-vpnc NetworkManager-vpnc-gnome abrt-desktop abrt-java-connector dconf-editor firewall-config gparted gtk2-engines gucharmap gvfs gvfs-afc gvfs-archive gvfs-fuse gvfs-gphoto2 gvfs-mtp gvfs-smb libmatekbd lightdm lightdm-gtk marco mate-applets mate-backgrounds mate-icon-theme mate-media mate-menus mate-menus-preferences-category-menu mate-notification-daemon mate-panel mate-polkit mate-power-manager mate-search-tool mate-session-manager mate-settings-daemon mate-system-log mate-themes mozo network-manager-applet seahorse setroubleshoot simple-scan system-config-date system-config-language system-config-users xdg-user-dirs-gtk
  # Etc
  sudo yum install -y gtk2-immodule-xim gtk3-immodule-xim ibus-gtk2 ibus-gtk3 imsettings-gsettings rdma-core
  # sudo yum install -y gstreamer1-plugins-bad-free gstreamer1-plugins-good gtk2-immodule-xim gtk3-immodule-xim ibus-gtk2 ibus-gtk3 imsettings-gsettings rdma-core
}

_deploy_fixes () {
  "fixfedorainput.sh"
  "fixguake.sh"
}

_deploy_fonts () {
  "setupfonts-el.sh"
  "setupnerdfonts.sh"

  if egrep -i -q 'ubuntu' /etc/*release ; then
    aptinstall.sh -r 'font-manager/staging' font-manager
  fi
}

_deploy_ppa () {
  egrep -i -q 'ubuntu' /etc/*release || return $?
  aptinstall.sh -r 'hsoft/ppa' $PKGS_GURU
  aptinstall.sh -r 'nathan-renniewaldock/qdirstat' qdirstat
  aptinstall.sh -r 'webupd8team/y-ppa-manager' y-ppa-manager
}

_deploy_pythontools () {
  typeset tools2="${DS_CONF}/packages/piplist-tools2"
  typeset tools3="${DS_CONF}/packages/piplist-tools3"
  typeset tools36="${DS_CONF}/packages/piplist3.6-tools3"

  # Get pipinstall.sh at https://stroparo.github.io/ds
  "pipinstall.sh" "$tools36"
  "pipinstall.sh" -e tools3 "$tools3"
  "pipinstall.sh" -e tools2 "$tools2"
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
# Composed deployments

_deploy_desktop () {
  "debselects-desktop.sh"
  "rpmselects-desktop.sh"
  _deploy_ppa
}

_deploy_devel () {
  "setuppython.sh"
  _deploy_vim

  # Etcetera
  "setupdocker.sh"
  "setupdocker-compose.sh"
  "setupexa.sh"
}

_deploy_develgui () {

  _deploy_fonts

  _user_confirm 'Setup Atom?'               && "setupatom.sh"
  _user_confirm 'Setup Sublime-Text?'       && "setupsubl.sh"
  _user_confirm 'Setup Visual Studio Code?' && "setupvscode.sh"

  sudo $INSTPROG install -y guake meld
}

# #############################################################################
# Custom deployments

_deploy_basecli () {
  _deploy_devel
  _deploy_fixes
}

_deploy_corpgui () {
  _deploy_basecli
  _deploy_baseguiel7
  "setupxfce.sh"
  "setuprdp.sh"
  _deploy_develgui

  # Etcetera
  "setupchrome.sh"
}

_deploy_pc () {
  _deploy_basecli
  "setupxfce.sh" -d
  _deploy_desktop
  _deploy_develgui

  # Distro agnostic setups:
  "setupanki.sh"
  "setupchrome.sh"
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
