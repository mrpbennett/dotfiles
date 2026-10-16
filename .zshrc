export PATH="$HOME/.local/bin:$PATH"

# PATH TO YOUR OH MY ZSH INSTALLATION.
export ZSH="$HOME/.oh-my-zsh"

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

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi # WorkTrunk



source ~/.config/shell/all.sh

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

dotfiles(){
  cd "$HOME/.dotfiles" || return
  nvim .
}

# Pi
export PATH="/Users/pbennett/.local/share/mise/installs/node/26.6.0/bin:$PATH"
eval "$(atuin init zsh)"
