# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

add () { git add -A "$@" ; git status -s ; }
addd () { git add -A "$@" ; git status -s ; git diff --cached ; }
gcheckedout () { git branch -v "$@" | egrep '^(==|[*]|---)' ; }
gci () { git commit -m "$@" ; }
gciarr () { git commit -m "Rearrange $1" ; }
gcicom () { git commit -m "Comment $1" ; }
gcifix () { git commit -m "Fix $1" ; }
gcifmt () { git commit -m "Format $1" ; }
gcirf () { git commit -m "Refactor $1" ; }
gcirn () { git commit -m "Rename $1" ; }
gcirm  () { git commit -m "Removed $1" ; }
gcitodo () { git commit -m "TODO added $1" ; }
gciup () { git commit -m "Updated $1" ; }
gciwp () { git commit -m "Work in progress $1" ; }
