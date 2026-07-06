# Go
export PATH="$PATH:$HOME/go/bin"
gomod() {
  if [ -z "$1" ]; then
    echo "Usage: gomod <module-name>"
    return 1
  fi
  go mod init "github.com/mrpbennett/$1"
}

# POETRY ---
alias pa="poetry add $1"
alias pr="poetry run python $1"
alias pin="poetry install"

# UV ---
alias ui="uv init"
alias ua="uv add $1"
alias us="uv sync"
alias ur="uv run $1"

# AI ---
alias hrc="herdr server reload-config"
alias oc="opencode"
