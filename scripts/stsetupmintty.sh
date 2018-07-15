#!/usr/bin/env bash

PROGNAME=czsetupmintty.sh

. "${DS_HOME:-$HOME/.ds}/ds.sh"
if ! ${DS_LOADED:-false} ; then
  echo "${PROGNAME:+$PROGNAME: }FATAL: No Daily Shells loaded." 1>&2
  exit 1
fi

if ! (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  echo "${PROGNAME:+$PROGNAME: }SKIP: No Daily Shells loaded." 1>&2
  exit
fi

export THEME_FILE=hybrid
cp "$(cygpath "$DEV")"/dotfiles/misc/ui-term-colors/hybrid-mintty.txt "$(cygpath "C:")"/opt/git/usr/share/mintty/themes/hybrid
cp "$(cygpath "$DEV")"/dotfiles/misc/ui-term-colors/ocean.dark-mintty.txt "$(cygpath "C:")"/opt/git/usr/share/mintty/themes/oceandark
cp "$(cygpath "$DEV")"/dotfiles/misc/ui-term-colors/tomorrow.dark-mintty.txt "$(cygpath "C:")"/opt/git/usr/share/mintty/themes/tomorrowdark

cat > $(cygpath "$USERPROFILE")/.minttyrc <<EOF
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
