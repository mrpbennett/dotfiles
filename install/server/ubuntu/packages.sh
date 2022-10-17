###############################################################################
# Ubuntu Packages #############################################################
###############################################################################

# First update system
sudo apt update -y && sudo apt upgrade -y

# Install the locate cmd
sudo apt install plocate -y

# Install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# NeoVim
sudo apt install neovim
sudo apt install python3-neovim
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip

sudo snap install docker # Docker

# Clean up packages
sudo apt clean
sudo apt autoremove