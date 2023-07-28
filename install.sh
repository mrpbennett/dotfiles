#!/usr/bin/bash

sudo apt install curl

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR

export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"

# Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"


# Update dotfiles itself first
if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi



# Creating bunch of symlinks 
echo "Creating symlinks...\n"
sleep 1

ln -sfv "$DOTFILES_DIR/.config/bash/.bashrc" $HOME # Bash config
ln -sfv "$DOTFILES_DIR/git/.gitconfig" $HOME # Git config
ln -sfv "$DOTFILES_DIR/.config/vim/.vimrc" $HOME # Vim
ln -sfv "$DOTFILES_DIR/.config/starship/starship.toml" "$HOME/.config" # Starship prompt
ln -sfv "$DOTFILES_DIR/


# PACKAGES #############################################################

# Check if MacOs or not.
unameOut=$(uname -s)

# install things if server OS = ubuntu
function ubuntu_install(){
    echo "Setting up Ubuntu"
    sleep 1

    . "$DOTFILES_DIR/install/desktop/ubuntu/packages.sh"
    . "$DOTFILES_DIR/install/bash-install.sh"
}


# INSTALLING PACKAGES CONDIONTIALLY ###########################################

if [[ "${unameOut}" == "Darwin" ]]; then

    echo "Setting up MacOS"
    sleep 1

    # MacOS
   . "$DOTFILES_DIR/install/desktop/macos/packages.sh"
   . "$DOTFILES_DIR/install/zsh-install.sh"
   . "$DOTFILES_DIR/macos/defaults.sh"
else
    # Linux
    ubuntu_install
fi











