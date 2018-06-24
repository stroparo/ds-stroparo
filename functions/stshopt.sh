# Daily Shells Stroparo extensions

stshopt () {

  if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
    set +o noclobber
    set -o vi
  fi

  if [ -n "$BASH_VERSION" ]; then
    set -o braceexpand
    set -o histexpand
    set -o notify # set -b

    _fast_git_ps1 () {
      printf -- "$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1} /')"
    }
    # PS1='\[\e]0;\w\a\]\n\$?=$?:\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] $\n'
    PS1="
"'\$?=$?:\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[33m\w$(_fast_git_ps1)\033[0m\]$ '"
"
  elif [ -n "$ZSH_VERSION" ]; then
    set +o nonotify # set -b
  fi

  export DISABLE_AUTO_TITLE=true
}
