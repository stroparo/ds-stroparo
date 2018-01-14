#!/usr/bin/env bash

# Daily Shells Private Stroparo extensions
# More instructions and licensing at:
# https://bitbucket.org/stroparo/ds-private

# #############################################################################
# Checks

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  echo "SKIP: Not on Linux." 1>&2
  exit
fi

# #############################################################################
# Main

echo "==> Started '$0'"

if [ ! -d "${HOME}"/.config/autostart ] ; then
  mkdir -p "${HOME}"/.config/autostart 2>/dev/null
fi

cat > "${HOME}"/.config/autostart/bootdesktop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=bootdesktop
Comment=
Exec=bash -ic 'type bootdesktop && bootdesktop'
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
EOF