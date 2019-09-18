# Daily Shells Stroparo extensions

# #############################################################################
# Aliases & other handy stuff

# Custom shell options:
stshopt

# Synchronization:
gdox () { v dotfiles ; (gdd | grep -qv ergodox) || (gdd && gciup ergodox && gpa) ; }

# #############################################################################
# Globals

# Basic
: ${DEV:=${HOME}/workspace} ; export DEV
: ${MYOPT:=/opt} ; export MYOPT ; mkdir -p "${MYOPT}/log" 2>/dev/null
if (uname -a | egrep -i -q "cygwin|mingw|msys|win32|windows") ; then
  export DEV="$(cygpath "${DEV}")"
  export MYOPT="${MOUNTS_PREFIX}/c/opt"
  if [ -d "$(cygpath "$USERPROFILE")/opt" ] ; then
    export MYOPT="$(cygpath "$USERPROFILE")/opt"
  fi
fi

# Editor
export EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=subl

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

https://stroparo@bitbucket.org/stroparo/links.git
https://stroparo@bitbucket.org/stroparo/python-notes.git
"

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
# Globals - PATH

# Basic
if [ -d "${HOME}/bin" ] ; then pathmunge -x "${HOME}/bin" ; fi

# opt dirs, avoiding a ~/opt duplicate:
if [ -d "${HOME}/opt" ] ; then mungemagic -a "${HOME}/opt" ; fi
if [ "${MYOPT}" != "${HOME}/opt" ] && [ -d "${MYOPT}" ] ; then mungemagic -a "${MYOPT}" ; fi

# #############################################################################

true # avoid failure while sourcing this file
