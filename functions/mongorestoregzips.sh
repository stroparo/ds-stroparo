mongorestoregzips () {
  for dump in "$@" ; do
    mongorestore --gzip --archive="$dump"
  done
}
