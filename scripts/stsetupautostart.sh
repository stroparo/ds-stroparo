#!/usr/bin/env bash

# #############################################################################
# Checks

if ! (uname -a | grep -i -q linux) ; then
  echo "SKIP: Not on Linux." 1>&2
  exit
fi

# #############################################################################
# Main

echo ${BASH_VERSION:+-e} "\n\n==> Started '$0'"

if [ ! -d "${HOME}"/.config/autostart ] ; then
  mkdir -p "${HOME}"/.config/autostart 2>/dev/null
fi

cat > "${HOME}"/.config/autostart/stbootdesktop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=bootdesktop
Comment=
Exec=$HOME/.ds/scripts/stbootdesktop.sh
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
EOF
