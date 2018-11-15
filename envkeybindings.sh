# DS - Daily Shells Extras extensions
# See further instructions and license on:
# https://github.com/stroparo/ds-extras

if [ -n "$ZSH_VERSION" ] \
  && [[ $- = *i* ]] \
  && ! echogrep -q 'search-backward$' "$DS_POST_CALLS"
then
  appendto DS_POST_CALLS 'bindkey \"^R\" history-incremental-search-backward'
fi
