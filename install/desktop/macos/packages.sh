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
)

brew install "${apps[@]}"

# Casks
apps=(
    appcleaner
    bitwarden
    spotify
    slack
    visual-studio-code
)

brew install --cask "${apps[@]}"

# Remove outdated versions from the cellar.
brew cleanup
