
export PATH="$HOME/.local/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# PATH TO YOUR OH MY ZSH INSTALLATION.
export ZSH="$HOME/.oh-my-zsh"

# STARSHIP
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# VI MODE START ---
bindkey -v
KEYTIMEOUT=1

zle-keymap-select() {
  local cursor=$( [[ $KEYMAP == vicmd ]] && echo '\e[1 q' || echo '\e[5 q' )
  echo -ne "$cursor"
}

zle-line-init() { echo -ne '\e[5 q'; }  # beam cursor on new prompt (insert mode)

zle -N zle-keymap-select
zle -N zle-line-init
# VIM MODE END ---

# XDG BASE DIRECTORY ---
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export EDITOR=/opt/homebrew/bin/nvim
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Created by `pipx` on 2026-01-08 16:32:56
export PATH="$PATH:/Users/paul/.local/bin"

# opencode
export PATH=/Users/paul/.opencode/bin:$PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(tv init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
#
#
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/pbennett/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Seperate shell files to keep .zshrc clean
export SHELL_SOURCE="/Users/pbennett/Developer/personal/dootfiles/shell/"
# ALIASES
source $SHELL_SOURCE/aliases.sh
source $SHELL_SOURCE/docker/aliases.sh
source $SHELL_SOURCE/kube/aliases.sh
source $SHELL_SOURCE/git/aliases.sh
source $SHELL_SOURCE/dev/aliases.sh
# FUNCTIONS
source $SHELL_SOURCE/fns/tmux/tmux.sh

# Added Scripts that are not commited to dootfiles
source ~/pulsepoint.sh

