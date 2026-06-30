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
alias e="exit"  # a swifter exit
alias v="nvim"  # quicker nvim
alias bt="btop" # better activity monitor
alias t="tmux"  # quicker tmux

alias cat="bat"     # a better cat
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
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
