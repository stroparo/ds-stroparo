#!/usr/bin/env bash

PROGNAME="stgitmirrorgithub.sh"

for repo in "$@"
do
  (
    cd "${repo}"
    repo_basename="$(basename "${repo%.git}")"
    mirror_url="$(git remote get-url mirror 2>/dev/null)"
    if [ -z "${mirror_url}" ] ; then
      if git remote add mirror "https://stroparo@github.com/stroparo/${repo_basename}.git" ; then
        echo ${BASH_VERSION:+-e} "${PROGNAME}: INFO: repo '${repo}' added mirror ==> \c"
        git remote get-url mirror
      fi
    else
      echo "${PROGNAME:+$PROGNAME: }SKIP: repo '${repo}' had mirror '${mirror_url}' already" 1>&2
    fi
  )
done
