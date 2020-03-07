stshopt () {

  if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
    set +o noclobber
    set -o vi
  fi

  if [ -n "$BASH_VERSION" ]; then
    set -o braceexpand
    set -o histexpand
    set -o notify # set -b
  elif [ -n "$ZSH_VERSION" ]; then
    set +o nonotify # set -b
  fi

  export DISABLE_AUTO_TITLE=true
}
