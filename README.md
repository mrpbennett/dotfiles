# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's in here

All configs live under `.config/` and cover:

| Tool | Purpose |
|------|---------|
| `fish` | Shell + functions/completions |
| `nvim` | Neovim (Lua config) |
| `tmux` | Multiplexer + TPM plugins |
| `zed` | Editor |
| `ghostty` | Terminal emulator |
| `zellij` | Terminal multiplexer (alt) |
| `starship` | Shell prompt |
| `atuin` | Shell history sync |
| `yazi` | File manager |
| `lazygit` / `lazydocker` | Git / Docker TUIs |
| `k9s` | Kubernetes TUI |
| `karabiner` | Keyboard remapping |
| `mise` | Runtime version manager |
| `bat` / `btop` | `cat` replacement / system monitor |
| `gh` / `gh-dash` | GitHub CLI + dashboard |
| `raycast` | Launcher extensions |
| `television` | Fuzzy finder |
| `nushell` | Nu shell config |

## Install

**Prerequisites:** `brew install stow`

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow --target="$HOME" .
```

Stow will symlink everything under `.config/` into `~/.config/`. If a target file already exists and isn't a symlink, stow will error — back it up first:

```sh
mv ~/.config/fish ~/.config/fish.bak   # example
```

To remove symlinks (unstow):

```sh
stow --target="$HOME" --delete .
```

## Adding new configs

1. Put the config under `.config/<tool>/` in this repo
2. Run `stow --target="$HOME" .` again — stow is idempotent

## Security note

**Never commit credentials to this repo.** Files with secrets (API keys, tokens, passwords) belong in `.gitignore`. Use a secrets manager or per-machine env files sourced outside this repo instead.

Add sensitive config files to `.gitignore`:

```
.config/bucky/config.toml
.config/argocd/config
```
# dootfiles
