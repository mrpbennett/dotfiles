###############################################################################
# Ubuntu Packages #############################################################
###############################################################################

# First update system
sudo apt update -y && sudo apt upgrade -y

# Install the locate cmd
sudo apt install plocate -y

# Install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


sudo snap install docker # Docker



# Clean up packages
sudo apt clean
sudo apt autoremove