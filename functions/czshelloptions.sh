czshelloptions () {
  if [ -n "$BASH_VERSION" ]; then
    set -b
    export PS1='[\u@\h \W $?]\$ '
  fi

  set -o vi
  export EDITOR=vim
}
