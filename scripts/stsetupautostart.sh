#!/usr/bin/env bash

PROGNAME='stsetupautostart.sh'

# #############################################################################
# Checks

if ! (uname -a | grep -i -q linux) ; then
  echo
  echo
  echo "${PROGNAME:+$PROGNAME: }SKIP: Only Linux is supported."
  exit
fi

# #############################################################################
# Main

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
Exec=$HOME/.zdra/scripts/stbootdesktop.sh
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
EOF
if [ $? -eq 0 ] ; then
  echo "${PROGNAME:+$PROGNAME: }INFO: Wrote config into '${HOME}/.config/autostart/stbootdesktop.desktop'."
else
  echo "${PROGNAME:+$PROGNAME: }FATAL: Error writing config into '${HOME}/.config/autostart/stbootdesktop.desktop'." 1>&2
  exit 1
fi
