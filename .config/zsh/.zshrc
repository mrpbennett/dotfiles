# PATHS ---
export ZSH="$HOME/.oh-my-zsh"                     #oh-my-zsh
export PATH="$PATH:/Users/paul/.local/bin"        #pipx
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" #krew

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Aliases ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias dev="cd ~/Developer"
alias dt="cd ~/Desktop"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# AWS
alias s3m="aws s3 ls --endpoint-url http://minio.70ld.home:9000 --profile homelab"

# Kuberenetes
alias k="kubectl --kubeconfig ~/.kube/homelab --context talos"
alias kw="kubectl --kubeconfig ~/.kube/work --context et-ma2-prod -n tam"
alias kw-token="cat ~/.kube/cache/oidc-login/lga-dm-dev/* | jq -r '.id_token'"

alias kctx="kubectl config get-contexts"
alias kuse="kubectl config use-context $1"

# Python Shortcuts
alias python="python3"
alias pip="pip3"
alias pa="poetry add $1"
alias ps="poetry shell"

# SSH
alias sshc="ssh-copy-id -i ~/.ssh/id_ed25519.pub $1"

li() {
  ssh -i ~/.ssh/id_ed25519.pub sysadm@"$2"
}

# Custom Tweaks ---
# opens VSC from the cmd line:
code() { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }

eval "$(starship init zsh)"
