#!/usr/bin/env bash

PROGNAME=stsetupmintty.sh

if ! (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: No Daily Shells loaded." 1>&2
  exit
fi

export THEME_FILE=base16modlt
cp -f -v ~/workspace/dotfiles/misc/ui-term-colors/base16defmodlt-minttyrc.txt "$(cygpath "C:")"/opt/git/usr/share/mintty/themes/base16modlt
cp -f -v ~/workspace/dotfiles/misc/ui-term-colors/hybrid-minttyrc.txt "$(cygpath "C:")"/opt/git/usr/share/mintty/themes/hybrid

cat > "$(cygpath "$USERPROFILE")"/.minttyrc <<EOF
BoldAsFont=-1
ThemeFile=${THEME_FILE}
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
ls -l "$(cygpath "$USERPROFILE")"/.minttyrc
grep "ThemeFile=" "$(cygpath "$USERPROFILE")"/.minttyrc
