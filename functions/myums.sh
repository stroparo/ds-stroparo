# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

myums () {
  nohup "${MYOPT:-$HOME/opt}/ums/UMS.sh" \
    > "${DS_ENV_LOG:-$HOME/log}/ums.log" \
    2>&1 \
    &
}
