# Seperate shell files to keep .zshrc clean
export SHELL_SOURCE="$HOME/.local/share/dootfiles/shell"
# INIT
source $SHELL_SOURCE/init.sh
# ENV VARS
source $SHELL_SOURCE/envs.sh
# ALIASES
source $SHELL_SOURCE/aliases/main.sh
source $SHELL_SOURCE/aliases/docker.sh
source $SHELL_SOURCE/aliases/kube.sh
source $SHELL_SOURCE/aliases/git.sh
source $SHELL_SOURCE/aliases/dev.sh
# FUNCTIONS
source $SHELL_SOURCE/fns/tmux/tmux.sh

# Scripts that are not to be commited to repo
source ~/pulsepoint.sh
