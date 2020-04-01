#!/usr/bin/env bash

PROGNAME="${0##*/}"

echo
echo "################################################################################"
echo "Git config (ds-stroparo) \$0='$0'"

# #############################################################################
# Requirements

. "${DS_HOME:-$HOME/.ds}/ds.sh"

# #############################################################################
# Base repos

clonemygits "$STGITS"

# #############################################################################
# Author

(
  cd "$DEV"
  MYEMAIL="stroparo@outlook.com" confgits $(echo ${STGITS_BASENAMES})
)

# #############################################################################
# Mirrors

if ${CZ_DO_GIT_MIRRORING:-false} ; then
  for repo in $(echo ${STGITS_BASENAMES}); do
    (
      cd "${DEV}/${repo}"
      git remote remove mirror 2>/dev/null
      git remote add mirror "https://stroparo@github.com/stroparo/${repo}.git" \
        && (git remote -v | grep ^mirror)
    )
  done
fi

# #############################################################################
# Other custom repos

_clone_custom_cz_repos () {
  if [ ! -e "${CZ_REPOS_PROFILE}" ] ; then
    echo "${PROGNAME:+$PROGNAME: }_clone_custom_cz_repos: SKIP: no file pointed to by CZ_REPOS_PROFILE (${CZ_REPOS_PROFILE})."
    return
  fi
  if [ -z "${CZ_REPOS_DIRNAME_URL}" ] ; then
    echo "${PROGNAME:+$PROGNAME: }_clone_custom_cz_repos: SKIP: Empty global variable 'CZ_REPOS_DIRNAME_URL'."
    return
  fi

  # Fetch for-loop elements from the (@@@) suffixes of variable names of the form 'CZ_REPO_@@@',
  # ... which are assigned in the file pointed by the CZ_REPOS_PROFILE global variable:
  for repo in \
    $(grep -w 'CZ_REPO_[^=]*=' "${CZ_REPOS_PROFILE}" | grep -v '_RXPR=' | sed -e 's/^export CZ_REPO_//' -e 's/=.*$//')
  do
    # Map the 'CZ_REPO_@@@' variable name's suffix i.e. @@@ to the final basename
    # ... in the URL to be cloned, such mappings being sed expressions in the
    # ... respective CZ_REPO_@@@_RXPR global variables:
    repo_basename="$(echo "${repo}" | tr '[[:upper:]]' '[[:lower:]]' | eval "sed -e \"\${CZ_REPO_${repo}_RXPR}\"")"

    if eval "test ! -d \"\${CZ_REPO_${repo}}\"" ; then
      eval "git clone \"${CZ_REPOS_DIRNAME_URL%/}/${repo_basename#/}.git\" \"\${CZ_REPO_${repo}}\""
    fi
  done
}

_clone_custom_cz_repos

# #############################################################################
