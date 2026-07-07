#!/usr/bin/env bash
# Already installed (e.g. via Homebrew's own installer) — nothing to do.
if xcode-select -p &>/dev/null; then
  echo "Command Line Tools already installed."
  return 0 2>/dev/null || exit 0
fi

# Create the trigger file that signals an unattended install
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# Find the latest CLT package label
PROD=$(softwareupdate -l |
  grep -B 1 -E 'Command Line Tools' |
  awk -F'*' '/\*/ {print $2}' |
  sed -e 's/^ Label: //' -e 's/^ *//' |
  sort -V |
  tail -1)

# Clean up the trigger file now; it only needed to exist for the listing above.
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# Install it
softwareupdate -i "$PROD" --verbose
