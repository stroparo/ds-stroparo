callapi () {
  typeset method="$1"
  typeset url="$2"
  typeset token="$3"
  curl -s -X ${method:-GET} ${token:+-H "PRIVATE-TOKEN: $token"} "$url"
}
