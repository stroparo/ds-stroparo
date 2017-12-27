czshelloptions () {

  set -o vi

  if [ -n "$BASH_VERSION" ]; then
    set -b
    export PS1='[\u@\h \W $?]\$ '
  fi
}
