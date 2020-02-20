# Call the custom configured routine responsible for synchronizing repositories

zr () {
  if type "${SYNC_REPOS_SCRIPT}" >/dev/null 2>&1 ; then
    "${SYNC_REPOS_SCRIPT}"
  else
    echo "FATAL: $SYNC_REPOS_SCRIPT (${SYNC_REPOS_SCRIPT}) does not exist" 1>&2
    return 1
  fi
}
