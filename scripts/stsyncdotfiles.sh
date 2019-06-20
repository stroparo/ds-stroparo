#!/usr/bin/env bash

PROGNAME="stsyncdotfiles.sh"

DOTFILES_RECIPES_SELECT="
alias
dotfiles
git
sshmodes
vim
"

echo
echo "${PROGNAME:+$PROGNAME: }INFO: Applying dotfiles configurations:" 1>&2
echo "${DOTFILES_RECIPES_SELECT}"
echo "${PROGNAME:+$PROGNAME: }INFO: Started..."
runr.sh ${DOTFILES_RECIPES_SELECT}
