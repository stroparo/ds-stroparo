#!/usr/bin/env bash

PROGNAME=stsetupmintty.sh

# #############################################################################
# Globals

: ${GIT_ROOT:=$(cygpath "C:")/opt/git} ; export GIT_ROOT
: ${THEME_FILE:=base16modlt} ; export THEME_FILE

# #############################################################################
# Checks

if ! (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: Not in Windows." 1>&2
  exit
fi

# GIT_ROOT fallback
if [ ! -d "${GIT_ROOT}/bin" ] ; then
  export GIT_ROOT="$(cygpath "$USERPROFILE")"/opt/git

  if [ ! -d "${GIT_ROOT}/bin" ] ; then
    echo "${PROGNAME:+$PROGNAME: }SKIP: No (GIT_ROOT=$GIT_ROOT)/bin dir." 1>&2
    exit
  fi
fi

# #############################################################################
# Routines

_setup_mintty_at_git_root () {
  typeset git_root="${1:-$(cygpath "C:")/opt/git}"
  [ -d "${git_root}/bin" ] || return

  cp -f -v ~/workspace/dotfiles/misc/ui-term-colors/base16defmodlt-minttyrc.txt "${git_root}"/usr/share/mintty/themes/base16modlt
  cp -f -v ~/workspace/dotfiles/misc/ui-term-colors/hybrid-minttyrc.txt "${git_root}"/usr/share/mintty/themes/hybrid
}

_setup_minttyrc () {

  cat > "$(cygpath "$USERPROFILE")"/.minttyrc <<EOF
BoldAsFont=-1
ThemeFile=${THEME_FILE:-base16modlt}
CursorType=block
FontHeight=12
FontSmoothing=default
Locale=en_US
Charset=UTF-8
Columns=237
Rows=56
PgUpDnScroll=yes
Term=xterm-256color
Language=en_US
AllowBlinking=yes
Transparency=off
ScrollbackLines=100000
Font=Ubuntu Mono derivative Powerlin
EOF

  # Output results:
  ls -l "$(cygpath "$USERPROFILE")"/.minttyrc
  grep "ThemeFile=" "$(cygpath "$USERPROFILE")"/.minttyrc

}

_main () {
  _setup_mintty_at_git_root "$GIT_ROOT"
  _setup_minttyrc
}

# #############################################################################
# Main

_main
