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
_deploy_vim () { _user_confirm "Compile Vim latest?" && "setupvim.sh" ; }

_deploy_pythontools () {
  typeset tools2="${DS_CONF}/packages/piplist-tools2"
  typeset tools3="${DS_CONF}/packages/piplist-tools3"
  typeset tools36="${DS_CONF}/packages/piplist3.6-tools3"

  # Get pipinstall.sh at https://stroparo.github.io/ds
  "pipinstall.sh" "$tools36"
  "pipinstall.sh" -e tools3 "$tools3"
  "pipinstall.sh" -e tools2 "$tools2"
}

# #############################################################################
# Wrappers

_deploy_basegui () {

  "debselects-desktop.sh"
  "rpmselects-desktop.sh"

  # Etcetera
  "fixfedorainput.sh"
  "fixguake.sh"
  "setupchrome.sh"
}

_deploy_baseguiel7 () {
  egrep -i -q '(centos|oracle|red *hat).* 7' /etc/*release || return
  # Fonts
  sudo yum install -y cjkuni-uming-fonts dejavu-sans-fonts dejavu-sans-mono-fonts dejavu-serif-fonts gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts google-crosextra-caladea-fonts google-crosextra-carlito-fonts jomolhari-fonts khmeros-base-fonts liberation-mono-fonts liberation-sans-fonts liberation-serif-fonts lklug-fonts madan-fonts nhn-nanum-gothic-fonts open-sans-fonts overpass-fonts paktype-naskh-basic-fonts paratype-pt-sans-fonts ucs-miscfixed-fonts
  # GNOME
  sudo yum install -y NetworkManager-libreswan-gnome PackageKit-command-not-found PackageKit-gtk3-module avahi baobab caribou caribou-gtk2-module caribou-gtk3-module cheese compat-cheese314 control-center evince file-roller file-roller-nautilus firstboot gdm gnome-bluetooth gnome-boxes gnome-classic-session gnome-clocks gnome-color-manager gnome-contacts gnome-dictionary gnome-disk-utility gnome-font-viewer gnome-getting-started-docs gnome-icon-theme-extras gnome-icon-theme-symbolic gnome-initial-setup gnome-packagekit gnome-packagekit-updater gnome-screenshot gnome-session gnome-session-xsession gnome-settings-daemon gnome-shell gnome-software gnome-system-log gnome-system-monitor gnome-terminal gnome-terminal-nautilus gnome-themes-standard gnome-tweak-tool gnome-user-docs gnome-weather gvfs-afp gvfs-goa libcanberra-gtk2 libcanberra-gtk3 libproxy-mozjs librsvg2 libsane-hpaio metacity mousetweaks orca rhn-setup-gnome sane-backends-drivers-scanners sushi vinagre vino xdg-desktop-portal-gtk ibus-chewing ibus-hangul ibus-kkc ibus-libpinyin ibus-m17n ibus-rawcode ibus-sayura ibus-table ibus-table-chinese m17n-contrib m17n-db icedtea-web
  # MATE
  sudo yum install -y NetworkManager-l2tp NetworkManager-openconnect NetworkManager-openvpn NetworkManager-pptp NetworkManager-vpnc NetworkManager-vpnc-gnome abrt-desktop abrt-java-connector atril atril-caja brasero caja caja-image-converter caja-open-terminal caja-sendto dconf-editor engrampa eom filezilla firefox firewall-config gnote gparted gtk2-engines gucharmap gvfs gvfs-afc gvfs-archive gvfs-fuse gvfs-gphoto2 gvfs-mtp gvfs-smb libmatekbd libmateweather lightdm lightdm-gtk marco mate-applets mate-backgrounds mate-calc mate-control-center mate-desktop mate-dictionary mate-disk-usage-analyzer mate-icon-theme mate-media mate-menus mate-menus-preferences-category-menu mate-notification-daemon mate-panel mate-polkit mate-power-manager mate-screensaver mate-screenshot mate-search-tool mate-session-manager mate-settings-daemon mate-system-log mate-system-monitor mate-terminal mate-themes mozo network-manager-applet pluma rhythmbox seahorse setroubleshoot simple-scan system-config-date system-config-language system-config-printer system-config-users totem transmission-gtk xchat xdg-user-dirs-gtk yumex
  # Etc
  sudo yum install -y gstreamer1-plugins-bad-free gstreamer1-plugins-good gtk2-immodule-xim gtk3-immodule-xim ibus-gtk2 ibus-gtk3 imsettings-gsettings rdma-core
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

_deploy_corp () {
  _deploy_devel
}

_deploy_corpgui () {

  _deploy_baseguiel7
  "setupxfce.sh"
  _deploy_develgui

  # Etcetera
  "setuprdp.sh"
}

_deploy_pc () {

  "setupxfce.sh"
  _deploy_basegui
  _deploy_devel
  _deploy_develgui

  # Distro specific setups:
  _deploy_ppa

  # Distro agnostic setups:
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
