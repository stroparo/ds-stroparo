#!/usr/bin/env bash

# Daily Shells Private Stroparo extensions
# More instructions and licensing at:
# https://bitbucket.org/stroparo/ds-private

for setup in autostart keybk380 ; do
  "$DS_HOME"/scripts/stsetup${setup}.sh
done
