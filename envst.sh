# Daily Shells Stroparo extensions

# #############################################################################
# Custom

stshopt # routine defined in ds-stroparo/functions

# #############################################################################
# Globals

export STGITS="
https://stroparo@bitbucket.org/stroparo/dotfiles.git
https://stroparo@bitbucket.org/stroparo/ds.git
https://stroparo@bitbucket.org/stroparo/ds-stroparo.git
https://stroparo@bitbucket.org/stroparo/runr.git

https://stroparo@gitlab.com/stroparo/links.git
https://stroparo@gitlab.com/stroparo/python-notes.git
"

: ${DEV:=${HOME}/workspace} ; export DEV
: ${DROPBOXHOME:=${HOME}/Dropbox} ; export DROPBOXHOME
: ${MYOPT:=/opt} ; export MYOPT ; mkdir -p "${MYOPT}/log" 2>/dev/null
: ${ONEDRIVEHOME:=${HOME}/OneDrive} ; export ONEDRIVEHOME
: ${PYTHONSTARTUP:=${HOME}/.pystartup} ; export PYTHONSTARTUP

# Cygwin
if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  export CYGWIN="$CYGWIN winsymlinks:nativestrict"

  export DEV="$(cygpath "${DEV}")"
  export DROPBOXHOME="$(cygpath "${DROPBOXHOME}")"
  export MYOPT="${MOUNTS_PREFIX}/c/opt"
  export ONEDRIVEHOME="$(cygpath "${ONEDRIVEHOME}")"

  alias exp='explorer "$(cygpath -w "$PWD")"'

  pathmunge -x "/c/Program Files (x86)/Google/Chrome/Application"
fi

# Path
if [ -d "${HOME}/opt" ] ; then mungemagic -a "${HOME}/opt" ; fi
if [ "${MYOPT}" != "${HOME}/opt" ] && [ -d "${MYOPT}" ] ; then mungemagic -a "${MYOPT}" ; fi
if [ -d "${HOME}/bin" ] ; then pathmunge -x "${HOME}/bin" ; fi

# Terminal
export LS_COLORS="ow=01;95:di=01;94"
[ -z "$TMUX" ] && export TERM="xterm-256color"

# #############################################################################
# Default editors

export EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=code

# Custom DIFFPROG global:
if which meld >/dev/null 2>&1 ; then
  export DIFFPROG="meld"
elif which kdiff3 >/dev/null 2>&1 ; then
  export DIFFPROG="kdiff3"
elif (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  if [ -x "${MYOPT}/meld/meld" ] ; then
    export DIFFPROG="${MYOPT}/meld/meld"
  elif [ -x "${MYOPT}/kdiff3/kdiff3" ] ; then
    export DIFFPROG="${MYOPT}/kdiff3/kdiff3"
  elif [ -f "${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe" ] ; then
    export DIFFPROG="${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe"
  fi
fi

# #############################################################################
# DS post calls

if [[ $- = *i* ]] \
  && [ -d "$DEV" ] \
  && ! echogrep -q 'cd "\$\{DEV\}"' "${DS_POST_CALLS}"
then
  appendto DS_POST_CALLS '([[ \$PWD = \$HOME ]] || [[ \$PWD = / ]]) && cd \"\${DEV}\" || true'
fi

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  # Keep interactivity check (test on $- variable) as gitr.sh
  #  itself loads DS and thus this can cause an infinite recursion:
  if [[ $- = *i* ]] && ! echogrep -q 'gitr.sh ss' "${DS_POST_CALLS}" ; then
    appendto DS_POST_CALLS '[ -d ds ] && gitr.sh ss || true'
  fi
fi

# #############################################################################

true # avoid failure while sourcing this file
