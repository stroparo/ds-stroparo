# Daily Shells Stroparo extensions

stshopt () {

  set -o vi

  if [ -n "$BASH_VERSION" ]; then
    set -b

    _fast_git_ps1 () {
      printf -- "$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1} /')"
    }
    # PS1='\[\e]0;\w\a\]\n\$?=$?:\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] $\n'
    PS1='\$?=$?:\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[33m\w$(_fast_git_ps1)\033[0m\]$ '"
"
  fi

  export DISABLE_AUTO_TITLE=true
}
