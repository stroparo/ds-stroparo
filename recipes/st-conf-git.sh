#!/usr/bin/env bash

PROGNAME="${0##*/}"

(cd "$DEV" ; MYEMAIL="cstropz@gmail.com" confgits dotfiles ds ds-extras ds-stroparo)

# Mirrors:
for repo in dotfiles ds{,-extras,-stroparo}; do (cd "$DEV"/$repo && git remote remove mirror 2>/dev/null) ; done
(cd "$DEV"/dotfiles && git remote add mirror 'https://stroparo@github.com/stroparo/dotfiles.git')
(cd "$DEV"/ds && git remote add mirror 'https://stroparo@github.com/stroparo/ds.git')
(cd "$DEV"/ds-extras && git remote add mirror 'https://stroparo@github.com/stroparo/ds-extras.git')
(cd "$DEV"/ds-stroparo && git remote add mirror 'https://stroparo@github.com/stroparo/ds-stroparo.git')
