# Function dot - run local dotfiles via runr
unalias dot 2>/dev/null
unset dot 2>/dev/null
dot () {
  (
    if [ -d "${DEV:-${HOME}/workspace}/dotfiles" ] ; then
      export RUNR_ASSETS_REPOS="${DEV:-${HOME}/workspace}/dotfiles"
    fi
    "${DS_HOME:-$HOME/.ds}"/scripts/runr.sh "$@"
  )
}
