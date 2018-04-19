# Daily Shells Stroparo extensions

confmygits () {
  # gitset is defined in the stroparo.github.io/ds project in the gitfunctions.sh

  for repo in dotfiles ds{,-extras,-stroparo} sublime-snippets ; do
    [ -d "$DEV/$repo/.git" ] || continue
    touch "$DEV/$repo/.git/config"
    gitset -e "$MYEMAIL" -n "$MYSIGN" -r -v -f "$DEV/$repo/.git/config"
  done
}
