# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Purpose: Boot desktop applications

bootdesktop () {

  # Make caps an additional ctrl:
  /usr/bin/setxkbmap -option "ctrl:nocaps"

  if type google-chrome >/dev/null 2>&1 && ! pgrep -fl google-chrome ; then
    google-chrome & disown
  fi

  # Quake style terminal emulator:
  if type guake >/dev/null 2>&1 && ! pgrep -fl guake ; then
    guake & disown
  fi

  # Display lighting following the sun at Curitiba, Brazil:
  if type flux >/dev/null 2>&1 && ! pgrep -fl flux; then
    flux -l -25 -g -49 -k 4700 & disown
  fi
}
