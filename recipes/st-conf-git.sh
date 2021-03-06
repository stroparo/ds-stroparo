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
echo "${PROGNAME}: INFO: Adding mirrors..."

if ${ST_DO_GIT_MIRRORING:-false} ; then
  stgitmirrorgithub.sh $(echo "${STGITS_BASENAMES}" | sed "s#^#${DEV:-${HOME}/workspace}/#")
fi

echo


# #############################################################################
echo "${PROGNAME}: INFO: Converting all from HTTPS to SSH..."

gitremotepatternreplace -v -r "mirror" "https://stroparo@\([^/]*\)/stroparo/" "git@\\1:stroparo/" "${DEV}"/*/
gitremotepatternreplace -v -r "origin" "https://stroparo@\([^/]*\)/stroparo/" "git@\\1:stroparo/" "${DEV}"/*/

for repo in \
  "${DEV}"/*/
do
  gittrackremotebranches -r "origin" "${repo}" "master" "develop"
done
