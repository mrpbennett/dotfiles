###############################################################################
# Ubuntu Packages #############################################################
###############################################################################

# First update system
sudo apt update -y && sudo apt upgrade -y

# install build-essentials
sudo apt install build-essential

# Install the locate cmd
sudo apt install plocate -y

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage

# Lazyvim
mv ~/.config/nvim ~/.config/nvim.bak

mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

# FiraCode Nerd Fonts
sudo apt install fonts-firacode

# Snap store installs
sudo snap install datagrip --classic
sudo snap install spotify
sudo snap install multipass


# Install Docker
. "$DOTFILES_DIR/install/desktop/ubuntu/docker.sh


# Clean up packages
sudo apt clean
sudo apt autoremove
