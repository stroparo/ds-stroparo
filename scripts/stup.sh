_update_git_repos () {
  for repo in "$@" ; do
    if [ -d "$repo" ] ; then
      (
        cd "$repo"
        pwd
        git pull origin master
        git push origin master
        echo "git status:"
        git status -s
        echo
      )
    fi
  done
}


stup () {
  _update_git_repos \
      "${MY_LIBCOMP_REPO}" \
      "${MY_TODO_REPO}"
  v
  rpull
}
