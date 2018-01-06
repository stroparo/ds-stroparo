# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Custom environment

stshopt # routine defined in ds-stroparo

export EDITOR=vim

: ${DEV:=${HOME}/workspace} ; export DEV
: ${DROPBOXHOME:=${HOME}/Dropbox} ; export DROPBOXHOME
: ${MYOPT:=${HOME}/opt} ; export MYOPT ; mkdir -p "${MYOPT}/log" 2>/dev/null
: ${ONEDRIVEHOME:=${HOME}/OneDrive} ; export ONEDRIVEHOME

# Cygwin
if [[ "$(uname -a)" = *[Cc]ygwin* ]] ; then
    export CYGWIN="$CYGWIN winsymlinks:nativestrict"

    export DEV="${HOME}/workspace"
    export DROPBOXHOME="$(cygpath "${DROPBOXHOME}")"
    export MYOPT="$(cygpath "${MYOPT:-C:\\opt}")"
    export ONEDRIVEHOME="$(cygpath "${ONEDRIVEHOME}")"
fi

# #############################################################################
# General PATH

pathmunge -x "${HOME}/bin"
mungerootopt
mungehomeopt

# #############################################################################
# Sublime

if [ -e ~/opt/subl ] ; then pathmunge -x ~/opt/subl ; fi
if [ -e /cygdrive/c/opt/subl ] ; then pathmunge -x /c/opt/subl ; fi

if ! which subl >/dev/null 2>&1 && which sublime_text >/dev/null 2>&1 ; then
  sudo ln "$(which sublime_text)" /usr/local/bin/subl
fi

# #############################################################################
# VSCode

if [ -e ~/opt/vscode ] ; then pathmunge -x ~/opt/vscode ; fi
if [ -e /cygdrive/c/opt/vscode ] ; then pathmunge -x /c/opt/vscode ; fi

# #############################################################################
# Default GUI editor

if which subl >/dev/null 2>&1 ; then
  export GIT_EDITOR="subl --wait --new-window"
  export VISUAL=subl
elif which Code >/dev/null 2>&1 ; then
  export GIT_EDITOR="Code"
  export VISUAL=Code
fi

# #############################################################################
# DS post calls

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then

  if ! echogrep -q 'cd "\$\{DEV\}"' "${DS_POST_CALLS}" ; then
    appendto DS_POST_CALLS \
      'if [[ $- = *i* ]] && [[ \$PWD = \$HOME ]]; then cd \"\${DEV}\"; fi'
  fi

  # Keep interactivity check (test on $- variable) as gitr.sh
  #  itself loads DS and thus this can cause an infinite recursion:
  if ! echogrep -q 'gitr.sh ss' "${DS_POST_CALLS}" ; then
    appendto DS_POST_CALLS \
      'if [[ $- = *i* ]] && [ -d ds ]; then gitr.sh ss; fi'
  fi
fi
