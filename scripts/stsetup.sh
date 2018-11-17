#!/usr/bin/env bash

for stsetup_script in "${DS_HOME}"/scripts/stsetup[a-z0-9_]*.sh ; do
  "${stsetup_script}"
done
