set -o vi

if [ -e /c/opt/subl ] ; then
  pathmunge -x /c/opt/subl
fi

if [ -n "$BASH_VERSION" ] ; then
  czbash
fi

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && d "${DEV:-$HOME/workspace}"; true'
  appendto DS_POST_CALLS '[[ $- = *i* ]] && echo 1>&2 && [ -d ds ] && gitr.sh ss; true'
fi
