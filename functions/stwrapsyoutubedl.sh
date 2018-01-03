# Daily Shells Stroparo extensions
# More instructions and licensing at:
# https://github.com/stroparo/ds-stroparo

ydl ()          { youtube-dl "$@" ; }
ydlaudio ()     { youtube-dl -f 140 "$@" ; }
ydlaudiobest () { youtube-dl -f bestaudio "$@" ; }
ydlx ()         { youtube-dl -x "$@" ; }
