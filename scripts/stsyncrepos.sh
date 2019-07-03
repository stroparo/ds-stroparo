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

  # Recursively pull in the devel workspace:
  cd "${DEV:-${HOME}/workspace}"
  if (pwd | fgrep -q "${DEV:-${HOME}/workspace}") ; then
    . "${DS_HOME:-${HOME}/.ds}/functions/gitrecursive.sh"
    rpull
  fi
}


_main "$@"
