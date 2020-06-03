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
(cd "$DEV" ; MYEMAIL="stroparo@outlook.com" confgits $(echo ${STGITS_BASENAMES})
)

# #############################################################################
# Other custom repos

_clone_custom_cz_repos () {
  : ${CZ_REPOS_DIRNAME_URL:=https://stroparo@bitbucket.org/stroparo/}; export CZ_REPOS_DIRNAME_URL

  # Fetch for-loop elements from the (@@@) suffixes of variable names of the form 'CZ_REPO_@@@':
  for repo in \
    $(declare -x | grep -w 'CZ_REPO_[^=]*=' | grep -v '_RXPR' | sed -e 's/^declare -x CZ_REPO_//' -e 's/=.*$//')
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
echo "${PROGNAME}: INFO: Adding mirrors..."

if ${ST_DO_GIT_MIRRORING:-false} ; then
  stgitmirrorgithub.sh $(echo ${STGITS_BASENAMES})
  stgitmirrorgithub.sh $(declare -x | grep -w 'CZ_REPO_[^=]*=' | grep -v '_RXPR' | sed -e 's/[^=]*=//' | tr -d '"')
fi

echo


# #############################################################################
echo "${PROGNAME}: INFO: Converting all from HTTPS to SSH..."

gitremotepatternreplace -v -r "mirror" "https://stroparo@\([^/]*\)/stroparo/" "git@\\1:stroparo/" "${DEV}"/*/
gitremotepatternreplace -v -r "origin" "https://stroparo@\([^/]*\)/stroparo/" "git@\\1:stroparo/" "${DEV}"/*/

for repo in \
  "${DEV}"/*/ \
  $(declare -x | grep -w 'CZ_REPO_[^=]*=' | grep -v '_RXPR' | sed -e 's/[^=]*=//' | tr -d '"')
do
  gittrackremotebranches -r "origin" "${repo}" "master" "develop"
done
