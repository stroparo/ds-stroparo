# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# Wrappers for gitr script from the Daily Shells library (stroparo/ds)

radd () { gitr.sh add -A "$@" ; gitr.sh status -s ; }
rcheckedout () { gitr.sh -v branch "$@" | egrep '^(==|[*]|---)' ; }
rci () { gitr.sh commit -m "$@" ; }
rdca () { gitr.sh diff --cached "$@" ; }
