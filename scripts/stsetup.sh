#!/usr/bin/env bash

# Daily Shells Private Stroparo extensions
# More instructions and licensing at:
# https://bitbucket.org/stroparo/ds-private

for stsetup_script in "$DS_HOME"/scripts/stsetup[a-z]*.sh ; do
  "${stsetup_script}"
done
