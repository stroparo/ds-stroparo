#!/usr/bin/env bash

# Daily Shells Private Stroparo extensions
# More instructions and licensing at:
# https://bitbucket.org/stroparo/ds-private

for stsetup in "$DS_HOME"/scripts/stsetup*sh ; do
  ${stsetup}
done
