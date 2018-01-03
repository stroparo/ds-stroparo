# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

myserviio () {
  nohup "${MYOPT:-$HOME/opt}/serviio/bin/serviio.sh" "$@" \
    > "${DS_ENV_LOG:-$HOME/log}/serviio.log" \
    2>&1 \
    &
  sleep 8
  "${MYOPT:-$HOME/opt}/serviio/bin/serviio-console.sh"
}
