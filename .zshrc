ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="/Users/paul/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="spaceship"

# SPACESHIP PROMPT
SPACESHIP_CHAR_SYMBOL="👉 "

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins
plugins=(
    git
    iterm2
    asdf
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='code'
fi

# Aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# Shortcuts
alias dt="cd ~/Desktop"
alias dev="cd ~/Developer"
alias dl="cd ~/Downloads"

# Node Shortcuts
alias nm="nodemon $1"

# Gatsby Shortcuts
alias gd="gatsby develop"
alias gbd="gatsby build"

# Python Shortcuts
alias p="python $1" # saves typing python every time.
alias pi="pipenv install $1" # allows you to just type the package
alias ps="pipenv shell" # start a env with just "ps"
alias pr="pipenv run python $1"

# Flask Shortcuts
alias fr="flask run" # start a flask app

# Django Shortcuts
alias rs="python manage.py runserver" # starts django server
alias dmm="python manage.py makemigrations" # makes db migrations in django
alias dm="python manage.py migrate" # migrates db in django

# opens VSC from the cmd line:
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# asdf
. /usr/local/opt/asdf/asdf.sh
