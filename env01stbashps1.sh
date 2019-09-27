ST1_COLOR_ON='\['
ST1_COLOR_OFF='\033[0m\]'
ST1_BRANCH_COLOR="32m"
ST1_DIR_COLOR="1;34m"
ST1_USER_COLOR="1;35m"


_st_bash_ps1 () {
  # Prompt reference model:
  # PS1='\[\e]0;\w\a\]\n\$?=$?:\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\] $\n'

  if [ -n "$(git branch 2>/dev/null | awk '$2 ~ /master|prod/')" ] ; then
    ST1_BRANCH_COLOR="1;31m"
  fi
  ST1_BRANCH="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')"
  ST1_BRANCH="${ST1_BRANCH:+ {${ST1_BRANCH}\} }"
  ST1_BRANCH="\\033[${ST1_BRANCH_COLOR}${ST1_BRANCH}"

  ST1_DIR="\\033[${ST1_DIR_COLOR}\\w"
  ST1_MSYSTEM="\\033]0;${MSYSTEM}:\\w\\007"
  ST1_USERHOST="\\033[${ST1_USER_COLOR}\\]\\u@\\h"

  if type work_in_progress >/dev/null 2>&1 ; then
    ST1_WIP="$(work_in_progress)"
    ST1_WIP="${ST1_WIP:+:${ST1_WIP}: }"
  fi

  PS1="
"'\$?=$?'":${ST1_COLOR_ON}${ST1_MSYSTEM}${ST1_USERHOST} ${ST1_COLOR_ON}${ST1_DIR}${ST1_BRANCH}${ST1_COLOR_OFF}${ST1_WIP}$
"
}


if [ -n "$BASH_VERSION" ] ; then
  PROMPT_COMMAND="_st_bash_ps1"
fi
