czshelloptions

# ##############################################################################
# Path

if [ -e /c/opt/subl ] ; then pathmunge -x /c/opt/subl ; fi

# ##############################################################################
# Post calls

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && d "${DEV:-$HOME/workspace}"; true'
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && [ -d ds ] && gitr.sh ss; true'
fi
