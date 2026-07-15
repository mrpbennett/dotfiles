if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# INIT
source ~/.local/share/dotfiles/default/shell/init.sh
# ENV VARS
source ~/.local/share/dotfiles/default/shell/envs.sh
# ALIASES
source ~/.local/share/dotfiles/default/shell/aliases/main.sh
source ~/.local/share/dotfiles/default/shell/aliases/docker.sh
source ~/.local/share/dotfiles/default/shell/aliases/kube.sh
source ~/.local/share/dotfiles/default/shell/aliases/git.sh
source ~/.local/share/dotfiles/default/shell/aliases/dev.sh
# FUNCTIONS
source ~/.local/share/dotfiles/default/shell/fns/tmux/tmux.sh

# Scripts that are not to be commited to repo
[ -f ~/pulsepoint.sh ] && source ~/pulsepoint.sh
