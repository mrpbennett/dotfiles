export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Created by `pipx` on 2025-05-12 10:44:14
export PATH="$PATH:/Users/paulbennett/.local/bin"

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export LANG=en_US.UTF-8
export EDITOR=/opt/homebrew/bin/nvim

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"

eval "$(uv generate-shell-completion zsh)"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias dev="cd ~/Developer"
alias dt="cd ~/Desktop"

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

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





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

