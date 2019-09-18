#!/usr/bin/env bash

PROGNAME="${0##*/}"

echo
echo "################################################################################"
echo "Git config (ds-stroparo) \$0='$0'"

. "${DS_HOME:-$HOME/.ds}/ds.sh"

clonemygits "$STGITS"

(
  cd "$DEV"
  MYEMAIL="stroparo@outlook.com" confgits \
    dotfiles \
    ds \
    ds-stroparo \
    runr \
    links \
    python-notes
)

# Mirrors:
if ! ${STGITS_NOMIRRORS:-false} ; then
  for repo in dotfiles ds ds-stroparo runr; do
    (
      cd "${DEV}/${repo}"
      git remote remove mirror 2>/dev/null
      git remote add mirror "https://stroparo@github.com/stroparo/${repo}.git" \
        && (git remote -v | grep ^mirror)
    )
  done
fi
