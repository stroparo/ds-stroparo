shelloptions


# Aliases for functions in ds/functions/umountcrypt.sh
alias hs=haltst
alias rs=rebootst


# Base custom globals:
export DIFFPROG="meld"
: ${DEV:=${HOME}/workspace}; export DEV
: ${MYOPT:=${HOME}/opt}; export MYOPT

# Base custom globals - Windows environment:
if type cygpath >/dev/null 2>&1 ; then
  if [ -z "$DEV" ] && [ -d "$(cygpath "$USERPROFILE")/workspace" ] ; then
    DEV="$(cygpath "$USERPROFILE")/workspace"
  fi
  export DEV

  if [ -z "$MYOPT" ] && [ -d "$(cygpath "$USERPROFILE")/opt" ] ; then
    MYOPT="$(cygpath "$USERPROFILE")/opt"
  fi
  export MYOPT

  export DIFFPROG="$(cygpath 'C:\Program Files (x86)\Meld\Meld.exe')"
  if [ ! -e "${DIFFPROG}" ] ; then
    export DIFFPROG="${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe"
  fi
fi

# Downloads HOME
if [ -z "${DOWNLOADS_HOME}" ] && [ -e "${HOME}/Downloads" ] ; then
  if [ -f /usr/bin/cygpath ] ; then
    export DOWNLOADS_HOME="$(cygpath "${USERPROFILE}")/Downloads"
  else
    export DOWNLOADS_HOME="${HOME}/Downloads"
  fi
fi

# Editor
export EDITOR="vim"
export FZF_DEFAULT_COMMAND='ag --ignore .git --ignore "*.pyc" -g ""'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export GIT_EDITOR="vim"
export PAGER="less"
export VISUAL="code" ; if ! which "${VISUAL}" >/dev/null 2>&1 ; then export VISUAL="subl" ; fi

# Path
pathmunge -i -x "${HOME}/bin"
pathmunge -i -x "${HOME}/workspace/move-to-next-monitor"
if [ -d "${HOME}/opt" ] ; then mungemagic -a "${HOME}/opt" ; fi
if [ "${MYOPT}" != "${HOME}/opt" ] && [ -d "${MYOPT}" ] ; then mungemagic -a "${MYOPT}" ; fi

# Path to libraries
if (uname -a | grep -i -q linux) ; then
  pathmunge -i -x -v 'LD_LIBRARY_PATH' '/usr/lib/x86_64-linux-gnu'
  if bash -c "ls -d \"${MYOPT:-$HOME/opt}\"/qt/[1-9]*.[0-9]*.*[0-9]/gcc_64/lib >/dev/null 2>&1" ; then
    pathmunge -i -x -v "${MYOPT:-$HOME/opt}"/qt/[1-9]*.[0-9]*.*[0-9]/gcc_64/lib
  fi
fi
: ${PYTHONSTARTUP:=${HOME}/.pystartup} ; export PYTHONSTARTUP

# Terminal
export LS_COLORS="ow=01;95:di=01;94"
[ -z "${TMUX}" ] && export TERM="xterm-256color"
if [ -n "$ZSH_VERSION" ] && [[ $- = *i* ]] && ! echogrep -q 'search-backward$' "$ZDRA_POST_CALLS" ; then
  appendto ZDRA_POST_CALLS 'bindkey \"^R\" history-incremental-search-backward'
fi

# #############################################################################
# Cygwin

if [ -f /usr/bin/cygpath ] ; then
  export CYGWIN="$CYGWIN winsymlinks:nativestrict"
  pathmunge -i -x \
    "$(cygpath 'C:\Program Files')/VSCodium" \
    "$(cygpath 'C:\Program Files')/VSCodium/bin" \
    "$(cygpath 'C:\Program Files')/TrueCrypt" \
    "$(cygpath 'C:\Program Files')/Oracle/VirtualBox" \
    "$(cygpath 'C:\Program Files')/Google/Chrome/Application" \
    "$(cygpath 'C:\Program Files')/Mozilla Firefox" \
    "$(cygpath 'C:\Program Files')/ClamAV" \
    "$(cygpath 'C:')/HashiCorp/Vagrant/bin" \
    "$(cygpath 'C:')/winbuilds" \
    /mingw64/bin
fi

# #############################################################################
# Env - Git

GITR_PARALLEL="false"
if [ $(hostname) = rambo ] ; then
  GITR_PARALLEL=true
fi
export GITR_PARALLEL

export STGITS_ORIGIN_DOMAIN="github.com"
export STGITS="
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/dotfiles.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/sidra.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/ds-js.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/ds-stroparo.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/runr.git

https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/devlinks.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/handy.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/move-to-next-monitor.git
https://stroparo@${STGITS_ORIGIN_DOMAIN}/stroparo/python-notes.git
"
STGITS_BASENAMES="$(echo "${STGITS}" | grep . | sed -e 's#^.*/##' -e 's/[.]git$//')"

# #############################################################################
# Scripting Library global for post calls

if [[ $- = *i* ]] && ! echogrep -q 'cd.*{DEV' "${ZDRA_POST_CALLS}" ; then
  appendto ZDRA_POST_CALLS '([[ \$PWD = \$HOME ]] || [[ \$PWD = / ]]) && cd \"\${DEV:-\$HOME/workspace}\" || true'
fi
if [[ "$(uname -a)" = *[Ll]inux* ]] && [[ $- = *i* ]] && ! echogrep -q 'then rss' "${ZDRA_POST_CALLS}" ; then
  appendto ZDRA_POST_CALLS 'if [[ \$PWD = \$DEV ]] ; then rss ; fi'
fi
