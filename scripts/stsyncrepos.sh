#!/bin/bash


_update_git_repos () {
  for repo in "$@" ; do
    if [ -d "$repo" ] ; then
      (
        cd "$repo"
        pwd
        git pull origin master
        # TODO add push to mirror remote (when it exists)
        echo "git status at '${PWD}':"
        git status -s
        git branch -vv
        echo
      )
    fi
  done
}


_main () {
  _update_git_repos \
      "${MY_LIBCOMP_REPO}" \
      "${MY_TODO_REPO}"
  v
  rpull
}


_main "$@"
