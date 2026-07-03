# INIT --- tool initializations (fish equivalents of init.sh)
atuin init fish | source
tv init fish | source
zoxide init fish | source
mise activate fish | source

# ENV VARS --- (fish equivalents of envs.sh)
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx LANG en_US.UTF-8
set -gx EDITOR /opt/homebrew/bin/nvim
set -gx POETRY_VIRTUALENVS_IN_PROJECT true
fish_add_path /Users/paul/.opencode/bin
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path "$HOME/.local/bin"

# KUBERNETES ---
set -gx KUBECONFIG "$HOME/.kube/config/home.yaml"
if set -q KREW_ROOT
    fish_add_path "$KREW_ROOT/bin"
else
    fish_add_path "$HOME/.krew/bin"
end

# Go
fish_add_path "$HOME/go/bin"

# FILE SYSTEM ---
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'

function ff
    nvim (fzf --preview 'bat --style=numbers --color=always {}')
end

# DIRS ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias dev="cd ~/Developer"
alias dt="cd ~/Desktop"

# HELPERS ---
alias e="exit"
alias v="nvim"
alias bt="btop"
alias t="tmux"
alias cat="bat"
alias curl="curlie"
alias lzg="lazygit"
alias lzd="lazydocker"
alias zj="zellij --new-session-with-layout my-default"
alias zjd="zellij --new-session-with-layout desktop"
alias zjdo="zellij --new-session-with-layout devops"
alias zjda="zellij --new-session-with-layout dual-agent"
alias zjs="tv zellij-sessions"
alias zshconfig="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"

function zd
    if test (count $argv) -eq 0
        cd ~
    else if test -d "$argv[1]"
        cd "$argv[1]"
    else
        z $argv && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    end
end

function y
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    set -l cwd (cat "$tmp")
    if test -n "$cwd" && test "$cwd" != "$PWD"
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# DOCKER ---
alias dc="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"
alias dspa="docker system prune -a --volumes -f"

# KUBERNETES ---
alias k="kubectl"
alias ka="k apply -f"
alias kg="k get"
alias kd="k describe"
alias kdel="k delete"
alias kgpo="k get pod"
alias kl="k logs -f"
alias kgd="k get deployments"
alias kns="kubens"
alias ke="k exec -it"
alias kcns="k config set-context --current --namespace"
alias kw-token="cat ~/.kube/cache/oidc-login/lga-dm-dev/* | jq -r '.id_token'"
alias kc="k config"
alias kctx="tv k8s-contexts"

function kdelp
    if test (count $argv) -eq 0
        echo "Usage: kdelp <namespace>"
        return 1
    end
    k delete pods -n $argv[1] --field-selector=status.phase==Succeeded
end

function kshpod
    set -l ns $argv[1]
    if test -z "$ns"
        set ns (kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    end
    if test -z "$ns"
        set ns default
    end
    set -l pod (kubectl get pods -n $ns --no-headers 2>/dev/null | fzf --prompt="Pod in $ns > " --layout=reverse | awk '{print $1}')
    test -z "$pod" && return 1
    kubectl exec -it -n $ns $pod -- /bin/bash
end

# HELM ---
alias hrl="helm repo list"
alias hru="helm repo update"
alias hsr="helm search repo ''"

function hsv
    helm show values $argv | bat -l yaml
end

# GIT ---
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gadd="git add"
alias ga="git add -p"
alias gcoall="git checkout -- ."
alias gr="git remote"
alias gre="git reset"
alias wsc="wt switch --create --execute=claude"

# DEV ---
function gomod
    if test (count $argv) -eq 0
        echo "Usage: gomod <module-name>"
        return 1
    end
    go mod init "github.com/mrpbennett/$argv[1]"
end

alias pa="poetry add"
alias pr="poetry run python"
alias pin="poetry install"
alias ui="uv init"
alias ua="uv add"
alias us="uv sync"
alias ur="uv run"
alias oc="opencode"

# TMUX ---
function tdl
    if test (count $argv) -eq 0
        echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$TMUX"
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir $PWD
    set -l ai $argv[1]
    set -l ai2 ""
    test (count $argv) -ge 2 && set ai2 $argv[2]
    set -l editor_pane $TMUX_PANE

    tmux rename-window -t "$editor_pane" (basename $current_dir)
    tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"
    set -l ai_pane (tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

    if test -n "$ai2"
        set -l ai2_pane (tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
        tmux send-keys -t "$ai2_pane" "$ai2" C-m
    end

    tmux send-keys -t "$ai_pane" "$ai" C-m
    tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
    tmux select-pane -t "$editor_pane"
end

function tds
    if test (count $argv) -gt 0
        echo "Usage: tds"
        return 1
    end
    if test -z "$TMUX"
        echo "You must start tmux to use tds."
        return 1
    end

    set -l current_dir $PWD
    set -l editor_pane $TMUX_PANE

    tmux rename-window -t "$editor_pane" (basename $current_dir)
    set -l terminal_pane (tmux split-window -v -p 50 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')
    set -l diff_pane (tmux split-window -h -p 50 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')
    set -l opencode_pane (tmux split-window -h -p 50 -t "$terminal_pane" -c "$current_dir" -P -F '#{pane_id}')

    tmux send-keys -t "$editor_pane" "nvim ." C-m
    tmux send-keys -t "$diff_pane" "hunk diff --watch" C-m
    tmux send-keys -t "$opencode_pane" "opencode" C-m
    tmux select-pane -t "$editor_pane"
end

function tdlm
    if test (count $argv) -eq 0
        echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$TMUX"
        echo "You must start tmux to use tdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 ""
    test (count $argv) -ge 2 && set ai2 $argv[2]
    set -l base_dir $PWD
    set -l first true

    tmux rename-session (basename $base_dir | tr '.:' '--')

    for dir in $base_dir/*/
        test -d $dir || continue
        set -l dirpath (string trim --right --chars=/ $dir)
        if test $first = true
            tmux send-keys -t "$TMUX_PANE" "cd '$dirpath' && tdl $ai $ai2" C-m
            set first false
        else
            set -l pane_id (tmux new-window -c "$dirpath" -P -F '#{pane_id}')
            tmux send-keys -t "$pane_id" "tdl $ai $ai2" C-m
        end
    end
end

function tsl
    if test (count $argv) -lt 2
        echo "Usage: tsl <pane_count> <command>"
        return 1
    end
    if test -z "$TMUX"
        echo "You must start tmux to use tsl."
        return 1
    end

    set -l count $argv[1]
    set -l cmd $argv[2]
    set -l current_dir $PWD
    set -l panes $TMUX_PANE

    tmux rename-window -t "$TMUX_PANE" (basename $current_dir)

    while test (count $panes) -lt $count
        set -l new_pane (tmux split-window -h -t "$panes[-1]" -c "$current_dir" -P -F '#{pane_id}')
        set panes $panes $new_pane
        tmux select-layout -t "$panes[1]" tiled
    end

    for pane in $panes
        tmux send-keys -t "$pane" "$cmd" C-m
    end

    tmux select-pane -t "$panes[1]"
end

function ts
    set -l session (sesh list --icons | fzf-tmux -p 80%,70% \
        --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
        --header '  ^a all ^t tmux ^g configs ^x zoxide ^f find' \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
        --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
        --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
        --preview-window 'right:55%' \
        --preview 'sesh preview {}' 2>/dev/null)
    if test -z "$session"
        set session (sesh list | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    end
    test -z "$session" && return
    sesh connect "$session"
end
