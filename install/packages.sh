###############################################################################
# MacOS packages ##############################################################
###############################################################################

###############################################################################
# HomeBrew ##############################################################
###############################################################################

# Install XCode command line toosl
xcode-select --install

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Apps
apps=(
    docker
    gh
    tree
    python
    black
    mitmproxy
    derailed/k9s/k9s
    curlie
)

brew install "${apps[@]}"

# Casks
apps=(
    appcleaner
    bitwarden
    slack
    visual-studio-code

    # terminal goodies
    warp
    ghostty
)

brew install --cask "${apps[@]}"

# Remove outdated versions from the cellar.
brew cleanup

###############################################################################
# Other ##############################################################
###############################################################################

# Install Posting for API terminal use
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install posting