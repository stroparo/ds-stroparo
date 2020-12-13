stcloseguiapps () {
  typeset timeout=2
  typeset applist="
chrome
flameshot
guake
keepassxc keepassxc-proxy
sublime_text plugin_host
ulauncher
xfce4-terminal
"

  firefoxclose
  killall -HUP $(echo ${applist}) >/dev/null 2>&1
  sleep ${timeout}
  ! pidof $(echo ${applist}) >/dev/null 2>&1
}
