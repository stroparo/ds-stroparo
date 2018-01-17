# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

stshopt () {

  set -o vi

  if [ -n "$BASH_VERSION" ]; then
    set -b
    export PS1='[\u@\h \W $?]\$ '
  fi

  export DISABLE_AUTO_TITLE=true
}
