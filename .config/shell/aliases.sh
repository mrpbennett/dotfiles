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
alias nn='NVIM_APPNAME="nvim-native" nvim'
alias bt="btop"                              # better activity monitor
alias t="tmux attach || tmux new -s Session" # quicker tmux
alias h="herdr"
alias cat="bat"     # a better cat
alias curl="curlie" # a better curl
alias lzg='lazygit'
alias lzd='lazydocker'

alias zshconfig="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"

# UV ---
alias ui="uv init"
alias ua="uv add"
alias us="uv sync"
alias ur="uv run"

# AI ---
alias hrc="herdr server reload-config"
alias oc="opencode"
alias ocu="curl -fsSL https://opencode.ai/install | bash"

# Go
gomod() {
  if [ -z "$1" ]; then
    echo "Usage: gomod <module-name>"
    return 1
  fi
  go mod init "github.com/mrpbennett/$1"
}

# DOCKER ---
alias d="docker"
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
    kubectl get pods -n "$ns" --no-headers 2>/dev/null |
      fzf --prompt="Pod in $ns > " --layout=reverse |
      awk '{print $1}'
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
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
