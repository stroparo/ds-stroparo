shelloptions

# Custom
export DOTFILES_SELECTS="${DOTFILES_SELECTS} alias dotfiles git sshmodes vim"
if [ -f /usr/bin/cygpath ] ; then
  if [ -z "$DEV" ] ; then export DEV="$(cygpath "$USERPROFILE")/workspace"; fi
  # MYOPT
  if [[ $MYOPT = [Cc]:* ]] ; then export MYOPT="$(cygpath "$MYOPT")"
  elif [ -z "$MYOPT" ] ; then export MYOPT="$(cygpath "$USERPROFILE")/opt" ; fi
  # DIFFPROG
  if [ -x "${MYOPT}/meld/meld" ] ; then export DIFFPROG="${MYOPT}/meld/meld"
  else export DIFFPROG="${MOUNTS_PREFIX}/c/Program Files (x86)/WinMerge/WinMergeU.exe" ; fi
else
  if [ -z "$DEV" ] ; then export DEV="${HOME}/workspace"; fi
  if [ -z "$MYOPT" ] ; then export MYOPT="${HOME}/opt"; fi
  export DIFFPROG="meld"
fi

# Editor
export EDITOR=vim
export FZF_DEFAULT_COMMAND='ag --ignore .git --ignore "*.pyc" -g ""'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export GIT_EDITOR=vim
export VISUAL=subl

# Path
if [ -d "${HOME}/bin" ] ; then pathmunge -x "${HOME}/bin" ; fi
if [ -d "${HOME}/opt" ] ; then mungemagic -a "${HOME}/opt" ; fi
if [ "${MYOPT}" != "${HOME}/opt" ] && [ -d "${MYOPT}" ] ; then mungemagic -a "${MYOPT}" ; fi

# Path to libraries
if [ -e /boot ] ; then pathmunge -x -v 'LD_LIBRARY_PATH' '/usr/lib/x86_64-linux-gnu' ; fi
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
    "$(cygpath 'C:\Program Files')/Oracle/VirtualBox" \
    "$(cygpath 'C:\Program Files')/TrueCrypt" \
    # "$(cygpath 'C:\Program Files (x86)')/Google/Chrome/Application" \
    # "$(cygpath 'C:\Program Files')/Mozilla Firefox" \
    # "$(cygpath 'C:\Program Files')/VeraCrypt"
fi

# #############################################################################
# Daily Shells - Git

GITR_PARALLEL="false"; if [ $(hostname) = rambo ] ; then GITR_PARALLEL=true ; fi ; export GITR_PARALLEL

export STGITS="
https://stroparo@bitbucket.org/stroparo/dotfiles.git
https://stroparo@bitbucket.org/stroparo/ds.git
https://stroparo@bitbucket.org/stroparo/ds-stroparo.git
https://stroparo@bitbucket.org/stroparo/runr.git

https://stroparo@bitbucket.org/stroparo/devlinks.git
https://stroparo@bitbucket.org/stroparo/links.git
https://stroparo@bitbucket.org/stroparo/python-notes.git
"

# #############################################################################
# Daily Shells - post calls

if [[ $- = *i* ]] && ! echogrep -q 'cd.*{DEV' "${DS_POST_CALLS}" ; then
  appendto DS_POST_CALLS '([[ \$PWD = \$HOME ]] || [[ \$PWD = / ]]) && cd \"\${DEV:-\$HOME/workspace}\" || true'
fi
if [[ $- = *i* ]] && [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  appendto DS_POST_CALLS 'if [[ \$PWD = \$DEV ]] ; then rss ; fi'
fi

# #############################################################################
