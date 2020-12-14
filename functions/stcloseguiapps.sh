stcloseguiapps () {
  typeset timeout=4
  typeset killnames="
flameshot
keepassxc keepassxc-proxy
sublime_text plugin_host
xterm
"
  typeset killnamescheck="${killnames} code firefox fsearch guake xfce4-terminal"

  # List of processes names which are not the command name (e.g. runs like <shell-filename> <file>):
  typeset killpidsnamesregex="ulauncher"
  typeset killpids="$(pgrep "${killpidsnamesregex}")"
  typeset killpidsregex="$(echo ${killpids} | tr '\n' ' ' | tr -s ' ' '|' | sed -e 's/  *//')"

  if which code >/dev/null 2>&1 ; then windowclose code 'Visual Studio Code' ; fi
  if which firefox >/dev/null 2>&1 ; then firefoxclose ; fi
  if which fsearch >/dev/null 2>&1 ; then windowclose fsearch ; fi

  # Terminal emulators
  guake -q
  if which xfce4-terminal; then windowclose xfce4-terminal 'Linux Lite Terminal' 'ctrl+shift+q' ; fi

  killall -HUP $(echo ${killnames}) >/dev/null 2>&1
  kill $(echo ${killpids}) >/dev/null 2>&1

  sleep ${timeout}

  # Return value based on all apps having been closed:
  ! pidof $(echo ${killnames}) >/dev/null 2>&1 \
  && [ -z "$(ps -ef | awk "$2 ~ /${killpidsregex}/")" ]
  return $?
}
