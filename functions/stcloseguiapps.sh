stcloseguiapps () {
  typeset timeout=4
  typeset killnames="
flameshot
fsearch
sublime_text plugin_host
"
  typeset killnamescheck="${killnames} code firefox guake xfce4-terminal"

  # List of processes names which are not the command name (e.g. runs like <shell-filename> <file>):
  typeset killpidsnamesregex="keepassxc|ulauncher"
  typeset killpids="$(pgrep "${killpidsnamesregex}")"
  typeset killpidsregex="$(echo ${killpids} | tr '\n' ' ' | sed -e 's/  *//' | tr -s ' ' '|')"

  if pgr firefox >/dev/null 2>&1 ; then firefoxclose ; fi

  # Terminal emulators
  if pgr guake ; then guake -q ; fi
  if pgr xfce4-terminal ; then windowclose xfce4-terminal 'Linux Lite Terminal' 'ctrl+shift+q' ; fi

  killall -HUP $(echo ${killnames}) >/dev/null 2>&1
  kill $(echo ${killpids}) >/dev/null 2>&1

  sleep ${timeout}

  # Return value based on all apps having been closed:
  ! pidof $(echo ${killnamescheck}) \
    && [ -z "$(ps -ef | awk "$2 ~ /${killpidsregex}/")" ]
  return $?
}
