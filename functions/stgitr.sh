# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Wrappers for gitr script from the Daily Shells library (stroparo/ds)

radd  () { gitr.sh add -A "$@" ; gitr.sh status -s ; }
rcheckedout () { gitr.sh -v branch "$@" | egrep '^(==|[*]|---)' ; }
rci   () { gitr.sh commit -m "$@" ; }
rdca  () { gitr.sh diff --cached "$@" ; }
rpul  () { gitr.sh -vp  pull "$@" ; }
rpuls () { gitr.sh -v   pull "$@" ; }
rpus  () { gitr.sh -vp  push "$@" ; }
rpuss () { gitr.sh -v   push "$@" ; }
rss   () { gitr.sh -vp  status -s "$@" ; }
rsss  () { gitr.sh -v   status -s "$@" ; }
