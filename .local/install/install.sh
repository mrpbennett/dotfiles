#!/usr/bin/env bash
set -euo pipefail

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

BREWFILE="$(dirname "$0")/Brewfile"
echo "Installing packages from $BREWFILE..."
brew bundle --file="$BREWFILE"

# Stow (installed by the Brewfile above) before oh-my-zsh: on a fresh machine
# there's no ~/.zshrc yet, so oh-my-zsh would otherwise write its own template
# there and stow would later refuse to symlink ours over it. Symlinking first
# + KEEP_ZSHRC=yes below makes oh-my-zsh see our .zshrc already in place and
# leave it alone.
stow --target="$HOME" .

# Install oh-my-zsh
KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install oh-my-zsh plugins
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install mise and install mise packages
curl https://mise.run | sh
# Same issue as brew: the installer doesn't update PATH for this session.
export PATH="$HOME/.local/bin:$PATH"
mise install

# Install TMP (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
