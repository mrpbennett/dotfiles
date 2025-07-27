export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"

# Created by `pipx` on 2025-05-12 10:44:14
export PATH="$PATH:/Users/paulbennett/.local/bin"

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export LANG=en_US.UTF-8

export EDITOR=/opt/homebrew/bin/nvim

export POETRY_VIRTUALENVS_IN_PROJECT=true

# wrap harlequin so it always picks up ~/.config/harlequin/config.toml
harlequin() {
  command harlequin --config-path "$XDG_CONFIG_HOME/harlequin/config.toml" "$@"
}



# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias dev="cd ~/Developer"
alias dt="cd ~/Desktop"

alias v="nvim"
alias ze="zellij"

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# Poetry 
alias pr="poetry run python $1"

# Git
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

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# K8S
export KUBECONFIG=$HOME/.kube/config/home.yaml:$HOME/.kube/config/pulsepoint.yaml
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'
alias kw-token="cat ~/.kube/cache/oidc-login/lga-dm-dev/* | jq -r '.id_token'"

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# FZF
alias fp="fzf --preview 'bat --color=always --style=numbers {}'"


# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Delete Application ArgoCD
alias argocd-delete="kubectl get application $1 -n argocd -o json | jq '.metadata.finalizers=[]' | kubectl replace -n argocd -f -"

# Open VSCode in current directory
code() { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }

# Delete stuck Kubernetes namespaces - example usage: delete_ns <namespace>
delete_ns() {
    if [ -z "$1" ]; then
        echo "❌ Usage: delete_ns <namespace>"
        return 1
    fi

    NS="$1"
    echo "⚠️  Forcing deletion of namespace: $NS"

    kubectl get namespace "$NS" -o json |
        jq '.spec.finalizers=[]' |
        kubectl replace --raw "/api/v1/namespaces/$NS/finalize" -f -

    echo "✅ Namespace '$NS' force deletion attempted."

}

# Work ---------------------------------
aws_() {
    aws s3 "$1" "s3://$2" --profile "$3"
}

build_tam() {
    if [[ -z $1 ]]; then
        echo "Usage: build_tam <image_name>"
        return 1
    fi

    docker buildx build \
        --platform linux/amd64 \
        --push \
        -t "registry.pulsepoint.com/tam/$1" \
        .
}

# Homelab
miniohl() {
    # $1 = command (ls, cp, rm, etc)
    # $2 = bucket name (e.g. "dev") or bucket/key (e.g. "dev/path/to/object")
    aws \
        --endpoint-url https://minio-prod.70ld.dev \
        --profile homelab \
        s3 "$1" "s3://$2"
}





eval "$(uv generate-shell-completion zsh)"
# Adding zoxide
eval "$(zoxide init zsh)"
# eza completions
export FPATH="/Users/paulbennett/eza/completions/zsh:$FPATH"

# Autostart zellij on shell creation
# eval "$(zellij setup --generate-auto-start zsh)"

