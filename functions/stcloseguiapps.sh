stcloseguiapps () {
  typeset timeout=4
  typeset killnames="
flameshot
fsearch
sublime_text plugin_host
"

  # List of processes names which are not the command name (e.g. runs like <shell-filename> <file>):
  typeset killpidsnamesregex="keepassxc|ulauncher"
  typeset killpids="$(pgrep "${killpidsnamesregex}")"

  timeout 10s bash -ic "windowclose code '//vscode'"
  timeout 10s bash -ic "windowclose firefox 'Mozilla Firefox'"

  killall -HUP $(echo ${killnames}) >/dev/null 2>&1
  kill $(echo ${killpids}) >/dev/null 2>&1

  if pgr guake ; then guake -q ; fi

  sleep ${timeout}
}
