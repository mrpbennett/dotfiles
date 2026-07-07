# INIT
source ~/.local/share/dotfiles/shell/init.sh
# ENV VARS
source ~/.local/share/dotfiles/shell/envs.sh
# ALIASES
source ~/.local/share/dotfiles/shell/aliases/main.sh
source ~/.local/share/dotfiles/shell/aliases/docker.sh
source ~/.local/share/dotfiles/shell/aliases/kube.sh
source ~/.local/share/dotfiles/shell/aliases/git.sh
source ~/.local/share/dotfiles/shell/aliases/dev.sh
# FUNCTIONS
source ~/.local/share/dotfiles/shell/fns/tmux/tmux.sh

# Scripts that are not to be commited to repo
[ -f ~/pulsepoint.sh ] && source ~/pulsepoint.sh
