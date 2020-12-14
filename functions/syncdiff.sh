syncdiff () {
  syncdiffgtk.sh & disown
  syncdiffsubl.sh & disown
  syncdiffvsc.sh & disown
}
