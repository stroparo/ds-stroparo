vncfhd () {
  vncserver :1 -geometry 1920x1080 -depth 32 \
    -desktop X \
    -auth /home/user/.Xauthority \
    -rfbwait 120000 \
    -rfbauth /home/user/.vnc/passwd \
    -rfbport 5901 \
    -fp /usr/share/fonts/X11/misc/,/usr/share/fonts/X11/Type1/,/usr/share/fonts/X11/75dpi/,/usr/share/fonts/X11/100dpi/ \
    -co /etc/X11/rgb
}
