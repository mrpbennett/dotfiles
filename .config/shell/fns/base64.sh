# encodes a string and copies to clipboard
function b64e() {
  echo -n "$1" | base64 | pbcopy
}

# decodes a string and copies to clipboard
function b64d() {
  echo -n "$1" | base64 -d | pbcopy
}
