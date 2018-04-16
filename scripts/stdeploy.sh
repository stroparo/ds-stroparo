#!/usr/bin/env bash

# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Globals

PROGNAME="$(basename "${0:-stdeploy.sh}")"

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

_print_bar () {
  echo "################################################################################"
}

_print_header () {
  _print_bar
  echo "$@"
  _print_bar
}

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
# Dependencies

if ! which unzip >/dev/null 2>&1 ; then
  sudo $APTPROG update \
    && sudo $APTPROG install -y unzip \
    || sudo $RPMPROG install -q -y unzip
fi

# #############################################################################
# Provision APT install script aptinstall.sh from the Daily Shells library

if ! which aptinstall.sh >/dev/null 2>&1 ; then
  if [ ! -e "$HOME/bin/aptinstall.sh" ] ; then
    mkdir "$HOME/bin" 2>/dev/null
    curl -LSfs -o "$HOME/bin/aptinstall.sh" --create-dirs \
      "https://raw.githubusercontent.com/stroparo/ds-extras/master/debian/aptinstall.sh"
  fi
  chmod u+x "$HOME/bin/aptinstall.sh"
  export PATH="$HOME/bin:$PATH"

  # Last check to be safe:
  if ! which aptinstall.sh >/dev/null 2>&1 ; then
    echo "FATAL: aptinstall.sh missing. Install Daily Shells and ds-extras plugin." 1>&2
    exit 1
  fi
fi

# #############################################################################
# Provision dotfiles

_provision_dotfiles () {
  if [ -d "$DEV/dotfiles" ] ; then
    export DOTFILES_DIR="$DEV/dotfiles"
    return
  else
    export DOTFILES_DIR="$1"
  fi

  rm -f "${DOTFILES_DIR}" >/dev/null 2>&1
  curl -LSfs -o "$HOME"/.dotfiles.zip \
    "https://github.com/stroparo/dotfiles/archive/master.zip" \
    && unzip -o "$HOME"/.dotfiles.zip -d "$HOME"
  find "${DOTFILES_DIR}" -name '*.sh' -type f -exec chmod u+x {} \;

  # DOTFILES_DIR root intentionally omitted from PATH as these must be called with absolute path:
  export PATH="${DOTFILES_DIR}/installers:${DOTFILES_DIR}/scripts:$PATH"
}

_provision_dotfiles "${DOTFILES_DIR:-$HOME/dotfiles-master}"

# #############################################################################
# Basic deployments

_deploy_baseguiel7 () {
  egrep -i -q '(centos|oracle|red *hat).* 7' /etc/*release || return
  _print_header "Base GUI for Enterprise Linux 7"
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

_deploy_dotfiles () {
  _print_header "Deploying dotfiles - calling '${DOTFILES_DIR}/setupdotfiles.sh'"
  "${DOTFILES_DIR}/setupdotfiles.sh" -f
}

_deploy_fixes () {
  _print_header "Deploying fixes"
  . ~/.ds/ds.sh
  "fixfedorainput.sh"
  "fixguake.sh"
}

_deploy_fonts () {
  _print_header "Fonts"
  setupfonts-el.sh
  setupnerdfonts.sh

  if egrep -i -q 'ubuntu' /etc/*release ; then
    aptinstall.sh -r 'font-manager/staging' font-manager
  fi
}

_deploy_nextcloud () {
  _print_header "NextCloud"
  aptinstall.sh -r nextcloud-devs/client nextcloud-client
}

_deploy_ppa () {
  egrep -i -q 'ubuntu' /etc/*release || return $?
  _print_header "Ubuntu PPA applications"
  aptinstall.sh -r 'hsoft/ppa' $PKGS_GURU
  aptinstall.sh -r 'nathan-renniewaldock/qdirstat' qdirstat
  aptinstall.sh -r 'nilarimogard/webupd8' woeusb
  aptinstall.sh -r 'webupd8team/y-ppa-manager' y-ppa-manager
}

_deploy_pythontools () {
  typeset tools2="${DS_CONF}/packages/piplist-tools2"
  typeset tools3="${DS_CONF}/packages/piplist-tools3"
  typeset tools36="${DS_CONF}/packages/piplist3.6-tools3"

  _print_header "Python tools"

  # Get pipinstall.sh at https://stroparo.github.io/ds
  pipinstall.sh "$tools36"
  pipinstall.sh -e tools3 "$tools3"
  pipinstall.sh -e tools2 "$tools2"
}

_deploy_rdpclient () {
  _print_header "RDP client"
  if egrep -i -q 'ubuntu' /etc/*release ; then
    aptinstall.sh -r 'remmina-ppa-team/remmina-next' $PKGS_REMMINA
  fi
}

_deploy_vim () {
  _print_header "Vim"
  "setupvim.sh" "python3"
}

_deploy_vpn () {
  _print_header "VPN client"
  if egrep -i -q 'debian|ubuntu' /etc/*release ; then
    aptinstall.sh network-manager-openconnect network-manager-vpnc
  fi
 }

# #############################################################################
# Composed deployments

_deploy_desktop () {
  _print_header "Desktop software"
  debselects-desktop.sh
  rpmselects-desktop.sh
  _deploy_ppa
}

_deploy_devel () {

  _print_header "Development tools"

  setuppython.sh
  _deploy_vim

  setupdocker.sh
  setupdocker-compose.sh
  setupexa.sh
}

_deploy_develgui () {

  _print_header "Development tools for graphical environments"

  _deploy_fonts

  "setupatom.sh"
  "setupsubl.sh"
  "setupvscode.sh"

  echo
  sudo $INSTPROG install -y guake meld
}

_deploy_basecli () {

  _print_header "Base CLI software"

  _deploy_dotfiles
  _deploy_devel
}

# #############################################################################
# Custom deployments

_deploy_leangui () {

  _deploy_basecli

  _print_header "GUI environment"
  _deploy_baseguiel7
  "setupxfce.sh"
  "setuprdp.sh" -y
  _deploy_develgui
  _deploy_fixes

  _print_header "GUI software"
  "setupchrome.sh"
}
# For backwards compatibility:
_deploy_corp () { _deploy_leangui ; }

_deploy_pc () {

  _deploy_basecli

  _print_header "PC GUI base: desktop, devel, fixes"
  "setupxfce.sh" -d
  _deploy_desktop
  _deploy_develgui
  _deploy_fixes

  _print_header "PC GUI etcetera: Dropbox, google-chrome etc."
  "setupanki.sh"
  "setupchrome.sh"
  "setupdropbox.sh"
}

_deploy_stroparo () {

  _print_header "Custom cz assets"

  dsload || . "${DS_HOME:-$HOME/.ds}/ds.sh" || return $?
  type stdeploy.sh || dsplugin.sh "stroparo/ds-stroparo"
  dsload

  "stsetup.sh"  # sets up bootdesktop etc.
}

_deploy_z () {

  _print_header "Custom assets"

  dsload || . "${DS_HOME:-$HOME/.ds}/ds.sh" || return $?
  type clonemygits || dsplugin.sh "stroparo/ds-extras"
  type czsetup.sh || dsplugin.sh "bitbucket.org/stroparo/ds-cz"
  dsload

  clonemygits
  hashall

  echo
  echo "==> czsetup.sh <=="
  echo
  echo "Review filesystem boot script in \$DS_HOME/.../cz*filesystem*.sh" 1>&2
  echo "etc. on only after that run czsetup.sh." 1>&2
  echo
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
