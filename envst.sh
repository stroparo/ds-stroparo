# Custom environment

czshelloptions

export EDITOR=vim

# ##############################################################################
# Sublime

if [ -e /c/opt/subl ] ; then pathmunge -x /c/opt/subl ; fi
if which subl >/dev/null 2>&1 ; then
  export GIT_EDITOR="subl --wait --new-window"
  export VISUAL=subl
fi

# ##############################################################################
# Post calls

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && d "${DEV:-$HOME/workspace}"; true'
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && [ -d ds ] && gitr.sh ss; true'
fi
