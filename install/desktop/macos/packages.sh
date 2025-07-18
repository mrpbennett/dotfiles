###############################################################################
# MacOS packages ##############################################################
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

    # python
    python
    black

    mitmproxy
    derailed/k9s/k9s
)

brew install "${apps[@]}"

# Casks
apps=(
    appcleaner
    bitwarden
    slack
    visual-studio-code
    warp
)

brew install --cask "${apps[@]}"

# Remove outdated versions from the cellar.
brew cleanup
