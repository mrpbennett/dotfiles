# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/pb/.docker/bin"
# End of Docker Desktop section.

if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Load all shell files
source ~/.local/share/dotfiles/default/shell/rc.fish
