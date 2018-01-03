# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Purpose: jdiskreport wrapper

myjdisk () {
  (cd "${MYOPT:-$HOME/opt}"/jdiskreport && nohup java -jar jdiskreport-1.4.0.jar "$@" \
    > "${DS_ENV_LOG:-$HOME/log}"/jdiskreport.log \
    2>&1 \
    &)
}
