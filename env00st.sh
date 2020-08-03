shelloptions


alias cs=clamscan

# Aliases for functions in ds/functions/umountcrypt.sh
alias hs=haltsafe
alias rs=rebootsafe


# Base custom globals:
export DIFFPROG="meld"
: ${DEV:=${HOME}/workspace}; export DEV
: ${MYOPT:=${HOME}/opt}; export MYOPT

# Base custom globals - Windows environment:
if type cygpath >/dev/null 2>&1 ; then
  export DEV="$(cygpath "$USERPROFILE")/workspace"
  export MYOPT="$(cygpath "$USERPROFILE")/opt"

  export DIFFPROG="$(cygpath 'C:\Program Files (x86)\Meld\Meld.exe')"
  if [ ! -e "${DIFFPROG}" ] ; then
    export DIFFPROG="${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe"
  fi
fi

# Editor
export EDITOR=vim
export FZF_DEFAULT_COMMAND='ag --ignore .git --ignore "*.pyc" -g ""'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export GIT_EDITOR=vim
export VISUAL="codium"

# Path
if [ -d "${HOME}/bin" ] ; then pathmunge -x "${HOME}/bin" ; fi
if [ -d "${HOME}/opt" ] ; then mungemagic -a "${HOME}/opt" ; fi
if [ "${MYOPT}" != "${HOME}/opt" ] && [ -d "${MYOPT}" ] ; then mungemagic -a "${MYOPT}" ; fi

# Path to libraries
if (uname -a | grep -i -q linux) ; then
  pathmunge -x -v 'LD_LIBRARY_PATH' '/usr/lib/x86_64-linux-gnu'
  if bash -c "ls -d \"${MYOPT:-$HOME/opt}\"/qt/[1-9]*.[0-9]*.*[0-9]/gcc_64/lib >/dev/null 2>&1" ; then
    pathmunge -x -v "${MYOPT:-$HOME/opt}"/qt/[1-9]*.[0-9]*.*[0-9]/gcc_64/lib
  fi
fi
: ${PYTHONSTARTUP:=${HOME}/.pystartup} ; export PYTHONSTARTUP

# Terminal
export LS_COLORS="ow=01;95:di=01;94"
[ -z "${TMUX}" ] && export TERM="xterm-256color"
if [ -n "$ZSH_VERSION" ] && [[ $- = *i* ]] && ! echogrep -q 'search-backward$' "$DS_POST_CALLS" ; then
  appendto DS_POST_CALLS 'bindkey \"^R\" history-incremental-search-backward'
fi

# #############################################################################
# Cygwin

if [ -f /usr/bin/cygpath ] ; then
  export CYGWIN="$CYGWIN winsymlinks:nativestrict"
  pathmunge -x \
    "$(cygpath 'C:')/HashiCorp/Vagrant/bin" \
    "$(cygpath 'C:\Program Files')/ClamAV" \
    "$(cygpath 'C:\Program Files')/Oracle/VirtualBox" \
    "$(cygpath 'C:\Program Files')/TrueCrypt" \
    "$(cygpath 'C:\Program Files')/VSCodium/bin" \
    "$(cygpath 'C:\Program Files')/VSCodium"
fi

# #############################################################################
# Daily Shells - Git

GITR_PARALLEL="false"
if [ $(hostname) = rambo ] ; then
  GITR_PARALLEL=true
fi
export GITR_PARALLEL

export STGITS="
https://stroparo@bitbucket.org/stroparo/dotfiles.git
https://stroparo@bitbucket.org/stroparo/ds.git
https://stroparo@bitbucket.org/stroparo/ds-js.git
https://stroparo@bitbucket.org/stroparo/ds-stroparo.git
https://stroparo@bitbucket.org/stroparo/runr.git

https://stroparo@bitbucket.org/stroparo/devlinks.git
https://stroparo@bitbucket.org/stroparo/handy.git
https://stroparo@bitbucket.org/stroparo/python-notes.git
"
STGITS_BASENAMES="$(echo "${STGITS}" | grep . | sed -e 's#^.*/##' -e 's/[.]git$//')"

# #############################################################################
# Daily Shells - post calls

if [[ $- = *i* ]] && ! echogrep -q 'cd.*{DEV' "${DS_POST_CALLS}" ; then
  appendto DS_POST_CALLS '([[ \$PWD = \$HOME ]] || [[ \$PWD = / ]]) && cd \"\${DEV:-\$HOME/workspace}\" || true'
fi
if [[ "$(uname -a)" = *[Ll]inux* ]] && [[ $- = *i* ]] && ! echogrep -q 'then rss' "${DS_POST_CALLS}" ; then
  appendto DS_POST_CALLS 'if [[ \$PWD = \$DEV ]] ; then rss ; fi'
fi
