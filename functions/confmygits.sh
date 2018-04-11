# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

confmygits () {
  # gitset is defined in the stroparo.github.io/ds project in the gitfunctions.sh
  gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/dotfiles/.git/config"
  gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/ds/.git/config"
  gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/ds-extras/.git/config"
  gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/ds-stroparo/.git/config"
  gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/sublime-snippets/.git/config"
}
