if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Load all shell files
source ~/.local/share/dotfiles/shell/rc.fish
