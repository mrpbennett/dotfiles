# Install XCode command line toosl
xcode-select --install

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Python
echo "Installing Python and Black..."
brew install python
brew install black

# CLI Tools
echo "Installing your AWESOME CLI tools..."
# Yazi - CLI file manager
brew install yazi ffmpeg sevenzip jq poppler resvg imagemagick font-symbols-only-nerd-font tree curlie derailed/k9s/k9s zoxide bat gh
brew install yazi --HEAD

# Posting - API tooling
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install --python 3.13 posting

# Starship prompt
curl -sS https://starship.rs/install.sh | sh



# Install Neovim & LazyVim ----------------
echo "Installing Neovim and LazyVim..."
brew install neovim
brew install lazygit fzf ripgrep fd

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
echo 'LazyVim will be installed in ~/.config/nvim'
# End LazyVim ----------------

# cask packages
echo "Installing cask packages..."
brew install --cask ghostty
brew install --cask warp
brew install --cask visual-studio-code
brew install --cask mitmproxy


# Remove outdated versions from the cellar.
brew cleanup