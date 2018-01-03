# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Purpose: Boot desktop applications

bootdesktop () {

  # Make caps an additional ctrl:
  /usr/bin/setxkbmap -option "ctrl:nocaps"

  # Quake style terminal emulator:
  if ! pgrep -fl guake ; then
    guake & disown
  fi

  # Display lighting following the sun at Curitiba, Brazil:
  if type flux >/dev/null 2>&1 ; then
    flux -l -25 -g -49 -k 4700 & disown
  fi

  # Mount custom partitions and start Dropbox if mount ok:
  if type czmount >/dev/null 2>&1 ; then
    czmount
  fi
  if [ -d ~/Dropbox/doc ] ; then
    startdropbox & disown
  fi
}
