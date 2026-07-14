#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../../../.." && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

# Install Homebrew if not found
echo "#######################################################################"
echo "No Homebrew found installing..."
echo "#######################################################################"
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # The installer only prints the shellenv line for you to run later; without
  # this, the brew bundle call below fails with "command not found" here.
  BREW_BIN=/opt/homebrew/bin/brew
  [ -x "$BREW_BIN" ] || BREW_BIN=/usr/local/bin/brew
  eval "$("$BREW_BIN" shellenv)"
fi

echo "#######################################################################"
echo "Installing packages from $BREWFILE..."
echo "#######################################################################"
brew bundle --file="$BREWFILE"

###############################################################################
# Stow (installed by the Brewfile above) before oh-my-zsh: on a fresh machine
# there's no ~/.zshrc yet, so oh-my-zsh would otherwise write its own template
# there and stow would later refuse to symlink ours over it. Symlinking first
# + KEEP_ZSHRC=yes below makes oh-my-zsh see our .zshrc already in place and
# leave it alone.
###############################################################################
echo "Now running STOW to generate symlinks..."
stow --dir="$REPO_ROOT" --target="$HOME" .

# Install oh-my-zsh
echo "#######################################################################"
echo "Installing oh-my-zsh with plugings..."
echo "#######################################################################"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Installing ZSH..."
  sudo apt-get update && sudo apt-get install -y zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# Install oh-my-zsh plugins
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "#######################################################################"
echo "Installing mise packages..."
echo "#######################################################################"
mise install

echo "#######################################################################"
echo "Installing TMP...(tmux plugin manager)"
echo "#######################################################################"
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

echo "#######################################################################"
echo "Installing Atuin..."
echo "#######################################################################"
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

echo "#######################################################################"
echo "Setting up AI agents..."
echo "#######################################################################"
source $REPO_ROOT/.local/share/dotfiles/install/ai/agents.sh

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "#######################################################################"
  echo "Setting up MacOS how I like it, will require a reboot..."
  echo "#######################################################################"
  source "$REPO_ROOT/.local/share/dotfiles/install/macos/defaults.sh"
fi
