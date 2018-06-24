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

    # Prompt reference model:
    # PS1='\[\e]0;\w\a\]\n\$?=$?:\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] $\n'

    _st_ps1 () {
      PS1_GIT_BRANCH_COLOR="32m"
      if [ -n "$(git branch | awk '$2 ~ /master|prod/')" ] ; then PS1_GIT_BRANCH_COLOR="1;31m" ; fi
      PS1_GIT_BRANCH="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1} /')"
      PS1="
"'\$?=$?:\[\033]0;$MSYSTEM:\w\007\033[1;35m\]\u@\h \[\033[1;34m\w\033[${PS1_GIT_BRANCH_COLOR}${PS1_GIT_BRANCH}\033[0m\]$ '"
"
    }
    PROMPT_COMMAND=_st_ps1

  elif [ -n "$ZSH_VERSION" ]; then
    set +o nonotify # set -b
  fi

  export DISABLE_AUTO_TITLE=true
}
