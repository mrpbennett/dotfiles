#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install more recent versions of macOS tools
echo ''
echo '\[._.]/ - Installing JS/Node things via homebrew...'
echo ''
brew install node
brew install npm
brew install eslint
brew install prettier

echo ''
echo '\[._.]/ - Installing nerdy things via homebrew...'
echo ''
brew install gh
brew install sass/sass/sass
brew install mysql
brew install tree
brew install zsh-syntax-highlighting
brew install docker
brew install gatsby-cli

# Install Main applications
echo ''
echo '\[._.]/ - Installing main GUI tools via homebrew cask...'
echo ''
# brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask alfred
brew install --cask slack
brew install --cask spotify

# Install Helpful applications
echo ''
echo '\[._.]/ - Installing secondary GUI tools via homebrew cask...'
echo ''
brew install --cask appcleaner
brew install --cask kite
brew install --cask the-unarchiver


# Remove outdated versions from the cellar.
brew cleanup
