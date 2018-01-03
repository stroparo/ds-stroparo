# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# python
py () { python3 "$@"; }
py2 () { python2 "$@"; }
py3 () { python3 "$@"; }

# systemctl
ctl () { sudo systemctl "$@" ; }
ctlstart () { sudo systemctl start "$@" ; }
ctlstop () { sudo systemctl stop "$@" ; }
ctlstat () { sudo systemctl status "$@" ; }
