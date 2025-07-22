# Install XCode command line toosl
xcode-select --install

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Python
brew install python
brew install black

# Github CLI
brew install gh

# CLI Tools
# Yazi - CLI file manager
brew install yazi ffmpeg sevenzip jq poppler resvg imagemagick font-symbols-only-nerd-font tree curlie derailed/k9s/k9s zoxide bat
brew install yazi --HEAD

# Posting - API tooling
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install --python 3.13 posting

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

# cask packages
brew install --cask ghostty
brew install --cask warp
brew install --cask visual-studio-code
brew install --cask mitmproxy

# Install Neovim & LazyVim ----------------
brew install neovim
brew install lazygit fzf ripgrep fd

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
# End LazyVim ----------------


# Install LazySQL
brew tap jorgerojas26/lazysql
brew install lazysql


# Remove outdated versions from the cellar.
brew cleanup