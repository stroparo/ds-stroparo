# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# #############################################################################
# Custom

alias syncbooks='(cd ~/Downloads/books && git pull && git push)'
alias synchandy='(cd ~/Downloads/handy && git pull && git push)'

stshopt # routine defined in ds-stroparo

# #############################################################################
# Globals

: ${DEV:=${HOME}/workspace} ; export DEV
: ${DROPBOXHOME:=${HOME}/Dropbox} ; export DROPBOXHOME
: ${MYOPT:=${HOME}/opt} ; export MYOPT ; mkdir -p "${MYOPT}/log" 2>/dev/null
: ${ONEDRIVEHOME:=${HOME}/OneDrive} ; export ONEDRIVEHOME
: ${PYTHONSTARTUP:=${HOME}/.pystartup} ; export PYTHONSTARTUP

# Cygwin
if [[ "$(uname -a)" = *[Cc]ygwin* ]] ; then
  export CYGWIN="$CYGWIN winsymlinks:nativestrict"

  export DEV="${HOME}/workspace"
  export DROPBOXHOME="$(cygpath "${DROPBOXHOME}")"
  export MYOPT="$(cygpath "${MYOPT:-C:\\opt}")"
  export ONEDRIVEHOME="$(cygpath "${ONEDRIVEHOME}")"

  alias explorerhere='explorer "$(cygpath -w "$PWD")"'
fi

# PATH
pathmunge -x "$HOME/bin"
if [ -d "$DEV/dotfiles/installers" ] ; then
  pathmunge -x "$DEV/dotfiles/installers"
elif [ -d "$HOME/dotfiles-master/installers" ] ; then
  pathmunge -x "$HOME/dotfiles-master/installers"
fi
mungemagic "$HOME/opt"

# Terminal
export LS_COLORS="ow=01;95:di=01;94"
[ -z "$TMUX" ] && export TERM="xterm-256color"

# #############################################################################
# Default editors

# EDITOR:
if which vim >/dev/null 2>&1 ; then
  export EDITOR=vim
  export GIT_EDITOR=vim
else
  export EDITOR=vi
  export GIT_EDITOR=vi
fi

# VISUAL editor:
if which subl >/dev/null 2>&1 ; then
  export VISUAL=subl
elif which code >/dev/null 2>&1 ; then
  export VISUAL=code
fi

# #############################################################################
# DS post calls

if [[ $- = *i* ]] \
  && [ -d "$DEV" ] \
  && ! echogrep -q 'cd "\$\{DEV\}"' "${DS_POST_CALLS}"
then
  appendto DS_POST_CALLS '[[ \$PWD = \$HOME ]] && cd \"\${DEV}\" || true'
fi

if [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  # Keep interactivity check (test on $- variable) as gitr.sh
  #  itself loads DS and thus this can cause an infinite recursion:
  if [[ $- = *i* ]] && ! echogrep -q 'gitr.sh ss' "${DS_POST_CALLS}" ; then
    appendto DS_POST_CALLS '[ -d ds ] && gitr.sh ss || true'
  fi
fi
