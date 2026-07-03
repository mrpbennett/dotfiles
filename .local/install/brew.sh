#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREWFILE="$(dirname "$0")/Brewfile"
echo "Installing packages from $BREWFILE..."
brew bundle --file="$BREWFILE"
