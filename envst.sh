# Daily Shells Stroparo extensions

# #############################################################################
# Custom

stshopt # shell custom options routine defined in ds-stroparo/functions

# #############################################################################
# Globals

# Basic
: ${DEV:=${HOME}/workspace} ; export DEV
: ${HANDY_REPO_DIR:=${MOUNTS_PREFIX}/z/handy} ; export HANDY_REPO_DIR
: ${MYOPT:=/opt} ; export MYOPT ; mkdir -p "${MYOPT}/log" 2>/dev/null
if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  export DEV="$(cygpath "${DEV}")"
  export MYOPT="$(cygpath "$USERPROFILE")/opt"
fi

# Cygwin
if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  export CYGWIN="$CYGWIN winsymlinks:nativestrict"
fi

# Terminal
export LS_COLORS="ow=01;95:di=01;94"
[ -z "${TMUX}" ] && export TERM="xterm-256color"

# #############################################################################
# Globals - Custom selects

export DOTFILES_SELECTS_ST="
alias
dotfiles
git
sshmodes
vim
"

export STGITS="
https://stroparo@bitbucket.org/stroparo/dotfiles.git
https://stroparo@bitbucket.org/stroparo/ds.git
https://stroparo@bitbucket.org/stroparo/ds-stroparo.git
https://stroparo@bitbucket.org/stroparo/runr.git

https://stroparo@gitlab.com/stroparo/links.git
https://stroparo@gitlab.com/stroparo/python-notes.git
"

# #############################################################################
# Globals - Default editors

export EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=subl

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
# Globals - Daily Shells - gitr parallel / concurrent jobs

if (uname -a | grep -i -q linux) \
  && ((cd ; git config -l | grep -q 'cred.*store') \
      || (ssh-add -l 2>/dev/null | egrep -i -q -w 'dsa|rsa|ssh'))
then
  export GITR_PARALLEL=true
else
  export GITR_PARALLEL=false
fi

# #############################################################################
# Globals - Daily Shells - post calls

if [[ $- = *i* ]] \
  && [ -d "$DEV" ] \
  && ! echogrep -q 'cd "\$\{DEV\}"' "${DS_POST_CALLS}"
then
  appendto DS_POST_CALLS '([[ \$PWD = \$HOME ]] || [[ \$PWD = / ]]) && cd \"\${DEV:-\$HOME/workspace}\" || true'
fi

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  # Keep interactivity check (test on $- variable) as gitr.sh
  #  itself loads DS and thus this can cause an infinite recursion:
  if [[ $- = *i* ]] && ! echogrep -q 'gitr.sh ss' "${DS_POST_CALLS}" ; then
    appendto DS_POST_CALLS '[ -d ./ds ] && gitr.sh ss || true'
  fi
fi

# #############################################################################
# PATH

# Basic
if [ -d "${HOME}/bin" ] ; then pathmunge -x "${HOME}/bin" ; fi

# opt dirs, avoiding a ~/opt duplicate:
if [ -d "${HOME}/opt" ] ; then mungemagic -a "${HOME}/opt" ; fi
if [ "${MYOPT}" != "${HOME}/opt" ] && [ -d "${MYOPT}" ] ; then mungemagic -a "${MYOPT}" ; fi

# #############################################################################
# Platform - Python

: ${PYTHONSTARTUP:=${HOME}/.pystartup} ; export PYTHONSTARTUP

# #############################################################################
# Tool - fzf - for fuzzy search support

if which ag >/dev/null 2>&1 ; then
  export FZF_DEFAULT_COMMAND='ag --ignore .git --ignore "*.pyc" -g ""'
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

# #############################################################################
# Aliases

alias exp='explorer "$(cygpath -w "$PWD")"'
alias gdox='v dotfiles ; (gdd | grep -qv ergodox) || (gdd && gciup ergodox && gpa)'

# #############################################################################

true # avoid failure while sourcing this file
