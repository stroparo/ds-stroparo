# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

confmygits () {
  # gitset is defined in the stroparo.github.io/ds project in the gitfunctions.sh

  for repo in dotfiles ds{,-extras,-stroparo} sublime-snippets ; do
    gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/$repo/.git/config"
  done
}
