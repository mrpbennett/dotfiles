# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Plugins
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='lvim'
else
  export EDITOR='lvim'
fi

# Aliases
alias zshconfig="lvim ~/.zshrc"
alias ohmyzsh="lvim ~/.oh-my-zsh"

# VIM configs
alias vconfig="lvim ~/.vimrc"
alias nvconfig="lvim /Users/paul/.config/nvim/init.vim"

# Shortcuts
alias dt="cd ~/Desktop"
alias dev="cd ~/Developer"
alias dl="cd ~/Downloads"


# Node Shortcuts
alias nm="nodemon $1"
alias tw="npm install -D tailwindcss postcss autoprefixer && npx tailwindcss init -p"
alias lint="npm install -D prettier eslint-config-prettier prettier-plugin-tailwindcss"

# Python Shortcuts
alias python="python3"
alias pip="pip3"
alias jn="jupyter notebook"

# Pipenv Shortcuts
alias pi="pipenv install $1" # allows you to just type the package
alias ps="pipenv shell" # start a env with just "ps"
alias pr="pipenv run python $1"

# Rust Shortcuts
alias r="rustc $1"

# Chrome Shortcuts
alias chrome="open -na Google\ Chrome --args --user-data-dir=/tmp/temporary-chrome-profile-dir --disable-web-security"

# Kubernetes Shortcuts
alias kc="kubectl"
alias kui="kubectl proxy -p 8002"
alias kconfig="code .kube/config"


# opens VSC from the cmd line:
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}


export PATH="$HOME/.poetry/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/paul/Desktop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/paul/Desktop/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/paul/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/paul/Desktop/google-cloud-sdk/completion.zsh.inc'; fi

eval $(thefuck --alias)

export PATH="/Users/paul/.deta/bin:$PATH"

eval "$(starship init zsh)"


# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

