# Programming editor in the current dir
cod () {
  if [ -n "$1" ] ; then
    "${VISUAL}" "$@"
  else
    "${VISUAL}" .
  fi
}
