#!/usr/bin/env bash

gdox () {
  cd "${DEV}/dotfiles"
  (git status -s | grep -qv ergodox) \
    || (git add -A . && git commit -m "Update ergodox" \
        && (git push origin master ; git push mirror master))
}

gdox
