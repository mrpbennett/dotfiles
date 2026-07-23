if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# INIT
source ~/.config/shell/init.sh
# ENV VARS
source ~/.config/shell/envs.sh
# ALIASES
source ~/.config/shell/aliases/main.sh
source ~/.config/shell/aliases/docker.sh
source ~/.config/shell/aliases/kube.sh
source ~/.config/shell/aliases/git.sh
source ~/.config/shell/aliases/dev.sh
# FUNCTIONS
source ~/.config/shell/fns/tmux/tmux.sh

# Scripts that are not to be commited to repo
[ -f ~/pulsepoint.sh ] && source ~/pulsepoint.sh
