# Custom environment

czshelloptions

export EDITOR=vim

# ##############################################################################
# Sublime

if [ -e ~/opt/subl ] ; then pathmunge -x ~/opt/subl ; fi
if [ -e /cygdrive/c/opt/subl ] ; then pathmunge -x /c/opt/subl ; fi

if ! which subl >/dev/null 2>&1 && which sublime_text >/dev/null 2>&1 ; then
  sudo ln "$(which sublime_text)" /usr/local/bin/subl
fi

# ##############################################################################
# VSCode

if [ -e ~/opt/vscode ] ; then pathmunge -x ~/opt/vscode ; fi
if [ -e /cygdrive/c/opt/vscode ] ; then pathmunge -x /c/opt/vscode ; fi

# ##############################################################################
# Default GUI editor

if which subl >/dev/null 2>&1 ; then
  export GIT_EDITOR="subl --wait --new-window"
  export VISUAL=subl
elif which Code >/dev/null 2>&1 ; then
  export GIT_EDITOR="Code"
  export VISUAL=Code
fi

# ##############################################################################
# Post calls

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && d "${DEV:-$HOME/workspace}"; true'
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && [ -d ds ] && gitr.sh ss; true'
fi
