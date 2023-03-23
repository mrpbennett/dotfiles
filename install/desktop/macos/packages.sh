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
    eslint
    gh
    node
    npm
    prettier
    sass/sass/sass
    tree
    
    # python 
    python
    black
    isort
    flake8
    pylint
)   

brew install "${apps[@]}"


# Casks
apps=(
    alfred
    appcleaner
    bitwarden
    fig
    ngrok
    spotify
    slack
    visual-studio-code
)

brew install --cask "${apps[@]}"

# Remove outdated versions from the cellar.
brew cleanup
