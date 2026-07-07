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
alias pa="poetry add"
alias pr="poetry run python"
alias pin="poetry install"

# UV ---
alias ui="uv init"
alias ua="uv add"
alias us="uv sync"
alias ur="uv run"

# AI ---
alias hrc="herdr server reload-config"
alias oc="opencode"
