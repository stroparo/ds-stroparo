stshopt () {

  if [ -n "$BASH_VERSION" ]; then
    set +o noclobber -o vi -o braceexpand -o histexpand -o notify
  elif [ -n "$ZSH_VERSION" ]; then
    set +o noclobber
    set -o vi
    set +o nonotify # set -b
  fi

  export DISABLE_AUTO_TITLE=true
}
