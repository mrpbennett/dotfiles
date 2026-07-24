#!/usr/bin/env bash
set -euo pipefail

export NONINTERACTIVE=1

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../../../.." && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

# Install Homebrew if not found
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    BREW_BIN=/opt/homebrew/bin/brew
    [ -x "$BREW_BIN" ] || BREW_BIN=/usr/local/bin/brew
    eval "$("$BREW_BIN" shellenv)"
fi

brew install unzip
brew bundle --file="$BREWFILE"

###############################################################################
# Stow (installed by the Brewfile above) before oh-my-zsh: on a fresh machine
# there's no ~/.zshrc yet, so oh-my-zsh would otherwise write its own template
# there and stow would later refuse to symlink ours over it. Symlinking first
# + KEEP_ZSHRC=yes below makes oh-my-zsh see our .zshrc already in place and
# leave it alone.
###############################################################################
echo "Now running STOW to generate symlinks..."
stow --no-folding --dir="$REPO_ROOT" --target="$HOME" .

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# Install oh-my-zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Install TPM with catppuccin
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
mkdir -p ~/.config/tmux/plugins/tmux
[ -d "$HOME/.config/tmux/plugins/tmux/.git" ] || git clone https://github.com/catppuccin/tmux.git "$HOME/.config/tmux/plugins/tmux"

# Install Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive

# install all mise packages from .config/mise/config.toml
mise install

source "$REPO_ROOT/macos/defaults.sh"
