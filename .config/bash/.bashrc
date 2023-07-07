# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/paul/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
OSH_THEME="font"

# Setting auto-complete
bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
OMB_PROMPT_SHOW_PYTHON_VENV=true # enable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
completions=(
	git
	composer
	ssh
)

aliases=(
	general
)

plugins=(
	git
	bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nvim'
else
	export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Start TMUX on terminal open
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# Aliases
alias bashconfig="nvim ~/.bashrc"
alias ohmybash="nvim ~/.oh-my-bash"
alias tmuxconf="nvim ~/.tmux.conf"

# Reload tmux conf
alias tmr="tmux source-file ~/.tmux.conf"

# Shortcuts
alias dt="cd ~/Desktop"
alias dev="cd ~/Developer"
alias dl="cd ~/Downloads"

# Python Shortcuts
alias python="python3"
alias pip="pip3"
alias jn="jupyter notebook"

# Pipenv Shortcuts
alias pi="pipenv install $1" # allows you to just type the package
alias ps="pipenv shell"      # start a env with just "ps"
alias pr="pipenv run python $1"

# AWS
s3pp() {
	aws s3 $1 "s3://pp-client-onboarding/$2" --profile pp-client-onboarding
}

# opens VSC from the cmd line:
code() { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/paul/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/home/paul/miniconda3/etc/profile.d/conda.sh" ]; then
		. "/home/paul/miniconda3/etc/profile.d/conda.sh"
	else
		export PATH="/home/paul/miniconda3/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Starship
eval "$(starship init bash)"
