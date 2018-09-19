#!/usr/bin/env bash

PROGNAME="${0##*/}"

echo
echo "################################################################################"
echo "Git config (ds-stroparo) \$0='$0'"

. "${DS_HOME:-$HOME/.ds}/ds.sh"

clonemygits "$STGITS"

(cd "$DEV" ; MYEMAIL="stroparo@outlook.com" confgits dotfiles ds ds-extras ds-stroparo runr)

# Mirrors:
for repo in dotfiles ds{,-extras,-stroparo} runr; do (cd "$DEV"/$repo && git remote remove mirror 2>/dev/null) ; done
(cd "$DEV"/dotfiles && git remote add mirror 'https://stroparo@github.com/stroparo/dotfiles.git')
(cd "$DEV"/ds && git remote add mirror 'https://stroparo@github.com/stroparo/ds.git')
(cd "$DEV"/ds-extras && git remote add mirror 'https://stroparo@github.com/stroparo/ds-extras.git')
(cd "$DEV"/ds-stroparo && git remote add mirror 'https://stroparo@github.com/stroparo/ds-stroparo.git')
(cd "$DEV"/runr && git remote add mirror 'https://stroparo@github.com/stroparo/runr.git')
