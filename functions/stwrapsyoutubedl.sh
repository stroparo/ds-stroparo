# Daily Shells Stroparo extensions

ydl ()          { youtube-dl "$@" ; }
ydlaudio ()     { youtube-dl -f 140 "$@" ; }
ydlaudiobest () { youtube-dl -f bestaudio "$@" ; }
ydlx ()         { youtube-dl -x "$@" ; }
