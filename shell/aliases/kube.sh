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
