#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../../../.." && pwd)"

# Install Homebrew if not found
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # The installer only prints the shellenv line for you to run later; without
  # this, the brew bundle call below fails with "command not found" here.
  BREW_BIN=/opt/homebrew/bin/brew
  [ -x "$BREW_BIN" ] || BREW_BIN=/usr/local/bin/brew
  eval "$("$BREW_BIN" shellenv)"
fi

BREWFILE="$SCRIPT_DIR/brew/Brewfile"
echo "Installing packages from $BREWFILE..."
brew bundle --file="$BREWFILE"

# Stow (installed by the Brewfile above) before oh-my-zsh: on a fresh machine
# there's no ~/.zshrc yet, so oh-my-zsh would otherwise write its own template
# there and stow would later refuse to symlink ours over it. Symlinking first
# + KEEP_ZSHRC=yes below makes oh-my-zsh see our .zshrc already in place and
# leave it alone.
echo "Now running STOW to generate symlinks..."
stow --dir="$REPO_ROOT" --target="$HOME" .

# Install XCode Command Line Tools
echo "Installing Command Line Tools..."
source "$SCRIPT_DIR/cmd-line-tools.sh"

# Install oh-my-zsh
echo "Installing oh-my-zsh with plugings..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# Install oh-my-zsh plugins
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install mise packages
echo "Installing mise packages..."
mise install

# Install TMP (tmux plugin manager)
echo "Installing TMP..."
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# Setup MacOS the way I like it.
echo "Setting up MacOS how I like it, will require a reboot..."
source "$SCRIPT_DIR/macos/defaults.sh"
