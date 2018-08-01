#!/usr/bin/env bash

PROGNAME="${0##*/}"

. "${DS_HOME:-$HOME/.ds}/ds.sh"
if ! ${DS_LOADED:-false} ; then
  echo "${PROGNAME:+$PROGNAME: }FATAL: No Daily Shells loaded." 1>&2
  exit 1
fi

clonemygits "$STGITS"

(cd "$DEV" ; MYEMAIL="cstropz@gmail.com" confgits dotfiles ds ds-extras ds-stroparo)

# Mirrors:
for repo in dotfiles ds{,-extras,-stroparo}; do (cd "$DEV"/$repo && git remote remove mirror 2>/dev/null) ; done
(cd "$DEV"/dotfiles && git remote add mirror 'https://stroparo@github.com/stroparo/dotfiles.git')
(cd "$DEV"/ds && git remote add mirror 'https://stroparo@github.com/stroparo/ds.git')
(cd "$DEV"/ds-extras && git remote add mirror 'https://stroparo@github.com/stroparo/ds-extras.git')
(cd "$DEV"/ds-stroparo && git remote add mirror 'https://stroparo@github.com/stroparo/ds-stroparo.git')
