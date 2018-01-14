# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

# systemctl
ctl () { sudo systemctl "$@" ; }
ctlstart () { sudo systemctl start "$@" ; }
ctlstop () { sudo systemctl stop "$@" ; }
ctlstat () { sudo systemctl status "$@" ; }
