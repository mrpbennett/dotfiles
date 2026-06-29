
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

# FILE SYSTEM ---
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'

alias ff='nvim "$(fzf --preview '\''bat --style=numbers --color=always {}'\'')"'

zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}


# DIRS ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias dev="cd ~/Developer"
alias dt="cd ~/Desktop"

# HELPERS ---
alias e="exit" # a swifter exit
alias v="nvim" # quicker nvim
alias bt="btop" # better activity monitor
alias t="tmux" # quicker tmux

alias cat="bat" # a better cat
alias curl="curlie" # a better curl

alias lzg='lazygit'
alias lzd='lazydocker'

alias zj="zellij --new-session-with-layout my-default"
alias zjd="zellij --new-session-with-layout desktop"
alias zjdo="zellij --new-session-with-layout devops"
alias zjda="zellij --new-session-with-layout dual-agent"
alias zjs="tv zellij-sessions"

alias zshconfig="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"

# Go
export PATH="$PATH:$HOME/go/bin"
gomod() {
  if [ -z "$1" ]; then
    echo "Usage: gomod <module-name>"
    return 1
  fi
  go mod init "github.com/mrpbennett/$1"
}


# POETRY ---
alias pa="poetry add $1"
alias pr="poetry run python $1"
alias pi="poetry install"

# UV ---
alias ui="uv init"
alias ua="uv add $1"
alias us="uv sync"
alias ur="uv run $1"

# GIT ---
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# WORKTREE ---
alias wsc='wt switch --create --execute=claude'

# DOCKER ---
alias dc="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"
alias dspa="docker system prune -a --volumes -f"

# KUBERNETES ---
export KUBECONFIG=$HOME/.kube/config/home.yaml
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias k="kubectl"
alias ka="k apply -f"
alias kg="k get"
alias kd="k describe"
alias kdel="k delete"
alias kgpo="k get pod"
alias kl='k logs -f'
alias kgd="k get deployments"
alias kns="kubens"
alias ke="k exec -it"
alias kcns='k config set-context --current --namespace'
alias kw-token="cat ~/.kube/cache/oidc-login/lga-dm-dev/* | jq -r '.id_token'"
alias kc='k config'
alias kctx='tv k8s-contexts'

kdelp() {
  if [ -z "$1" ]; then
    echo "Usage: kdelp <namespace>"
    return 1
  fi
  k delete pods -n "$1" --field-selector=status.phase==Succeeded
}

kshpod() {
  local ns pod

  ns="${1:-$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)}"
  ns="${ns:-default}"

  pod="$(
    kubectl get pods -n "$ns" --no-headers 2>/dev/null \
      | fzf --prompt="Pod in $ns > " --layout=reverse \
      | awk '{print $1}'
  )"

  [ -z "$pod" ] && return 1

  kubectl exec -it -n "$ns" "$pod" -- /bin/bash
}

# HELM ---
alias hrl="helm repo list"
alias hru="helm repo update"
alias hsr="helm search repo ''"
hsv() {
  helm show values "$@" | bat -l yaml
}

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
unalias ts 2>/dev/null
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


# Added Scripts that are not commited to dootfiles
source ~/pulsepoint.sh
source /Users/pbennett/Developer/personal/dootfiles/shell/fns/tmux/tmux.sh

