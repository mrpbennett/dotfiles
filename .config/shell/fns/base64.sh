b64e() {
  printf "%s" "$*" | base64
}

b64d() {
  if base64 --help >/dev/null 2>&1; then
    base64 --decode
  else
    base64 -D
  fi
}
