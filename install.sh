#!/bin/zsh

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR

DOTFILES_DIR="$HOME/.dotfiles"

# Creating symlinks 
echo "Creating symlinks..."


ln -sfv "$DOTFILES_DIR/.config/zsh/.zshrc" $HOME # ZSH config
ln -sfv "$DOTFILES_DIR/.config/bash/.bashrc" $HOME # Bash config

ln -sfv "$DOTFILES_DIR/git/.gitconfig" $HOME # Git config

ln -sfv "$DOTFILES_DIR/.config/vim/.vimrc" $HOME # Vim
ln -sfv "$DOTFILES_DIR/.config/nvim" "$HOME/.config" # NeoVim
ln -sfv "$DOTFILES_DIR/.config/lvim" "$HOME/.config" # LunarVim

ln -sfv "$DOTFILES_DIR/.config/kitty/kitty.conf" "$HOME/.config" # Kitty conf

ln -sfv "$DOTFILES_DIR/.config/starship/starship.toml" "$HOME/.config" # Starship prompt


# SERVER PACKAGES #############################################################

# install things if server OS = ubuntu
function ubuntu_install(){
    echo "Setting up Ubuntu"
    sleep 1

    . "$DOTFILES_DIR/install/server/ubuntu/packages.sh"
    . "$DOTFILES_DIR/install/bash-install.sh"
}

# install things if server OS = centos
function centos_install(){
    echo "Setting up CentOS"
    sleep 1

    . "$DOTFILES_DIR/install/server/centos/packages.sh"
    . "$DOTFILES_DIR/install/bash-install.sh"
}


# INSTALLING PACKAGES CONDIONTIALLY ###########################################

# Check if MacOs or not.
unameOut=$(uname -s)

# Check for server OS
serverOS=$(cat /etc/os-release)


if [[ "${unameOut}" == "Darwin" ]]; then
    # MacOS
   . "$DOTFILES_DIR/install/desktop/macos/packages.sh"
   . "$DOTFILES_DIR/install/zsh-install.sh"
   . "$DOTFILES_DIR/macos/defaults.sh"
else
    # Linux

    # Check if server os is ubuntu or centos then install packages
    while read os; do
        if [ "$os" == "ID=ubuntu" ]; then
            # ubuntu srv
            ubuntu_install
        else
            # centos
            centos_install
        fi
    done < serverOS
    
fi











