zr () {
  if [ -f "${SYNC_REPOS_SCRIPT}" ] ; then
    "${SYNC_REPOS_SCRIPT}"
  else
  	echo "FATAL: $SYNC_REPOS_SCRIPT (${SYNC_REPOS_SCRIPT}) does not exist" 1>&2
  	return 1
  fi
}
