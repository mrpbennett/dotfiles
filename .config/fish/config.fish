if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ALIASES ---
# FILE SYSTEM ---
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'

alias ff='nvim "$(fzf --preview '\''bat --style=numbers --color=always {}'\'')"'

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

alias dlv='NVIM_APPNAME="dev-nvim" nvim'
alias ks='NVIM_APPNAME="ksnvim" nvim'

alias lzg='lazygit'
alias lzd='lazydocker'

alias zj="zellij"
alias zjd="zellij --layout ~/.config/zellij/layouts/desktop.kdl" # desktop layout for zellij
alias zjl="zellij --layout ~/.config/zellij/layouts/laptop.kdl" # laptop layout for zellij
alias zjdo="zellij --layout ~/.config/zellij/layouts/devops.kdl" # devops layout for zellij
alias zja="zellij --layout ~/.config/zellij/layouts/dual-agent.kdl" # dual-agent layout for zellij

alias zshconfig="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"

# Go
export PATH="$PATH:$HOME/go/bin"

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
export KUBECONFIG=$HOME/.kube/config/home.yaml:$HOME/.kube/config/pulsepoint.yaml

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

starship init fish | source
