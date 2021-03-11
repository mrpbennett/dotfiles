# Variables
dir=~/.dotfiles
files=(".zshrc" ".eslintrc.json" ".gitconfig")

# Lets make it look nicer
echo ""
echo "- - - - - - - - - -"
echo ""

# change to the dotfiles directory
echo "\[._.]/ - Changing to the $dir directory"
cd $dir

# Lets make it look nicer
echo ""
echo "- - - - - - - - - -"
echo ""

# Create symlinks
for file in $files; do
  echo "\[._.]/ - Creating symlink to $file in home directory."
  ln -s $dir/$file ~/$file
  echo "- - -"
done

# Lets make it look nicer
echo ""
echo "- - - - - - - - - -"
echo ""
echo "\[^_^]/ - All done. Have a great day."
echo " "
echo "- - - - - - - - - -"
echo ""

# initialize new settings
source ~/.zshrc
