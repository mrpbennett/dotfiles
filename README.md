<h1 align="center">
    <img src="assets/mascot.png" width="350" alt="Dot Mascot"/>
    <br/>
    <sub>dotfiles</sub>
</h1>

<p align="center">
    <img alt="GNU Stow" src="https://img.shields.io/badge/managed_with-GNU_Stow-4CAF50?style=flat-square&logo=gnu&logoColor=white"/>
    <img alt="macOS" src="https://img.shields.io/badge/platform-macOS-000000?style=flat-square&logo=apple&logoColor=white"/>
    <img alt="zsh shell" src="https://img.shields.io/badge/shell-zsh-4FC3F7?style=flat-square"/>
    <img alt="LazyVim" src="https://img.shields.io/badge/editor-LazyVim-7C3AED?style=flat-square"/>
</p>

<p align="center">Personal configuration files — symlinked, versioned, and ready to clone.</p>

---

## Table of Contents

- [What's in here](#whats-in-here)
- [Fresh machine setup](#fresh-machine-setup)
- [Stow reference](#stow-reference)
- [Day-to-day workflows](#day-to-day-workflows)
- [Recovering from conflicts](#recovering-from-conflicts)
- [Security](#security)
- [Quick cheatsheet](#quick-cheatsheet)

---

## What's in here

All configs live under `.config/` and are symlinked into `~/.config` via GNU Stow. The repo root mirrors your home directory — stow creates the links, git tracks the content.

### Shell

| Config     | What it does                                                                                 |
| ---------- | -------------------------------------------------------------------------------------------- |
| `zsh`      | Primary shell — functions, completions, abbreviations, and `$PATH` setup all live here       |
| `nushell`  | Nu shell config for when you want structured data pipelines instead of text streams          |
| `starship` | Cross-shell prompt that shows only what's relevant: git state, language versions, exit codes |
| `atuin`    | Replaces shell history with a searchable, syncable SQLite database                           |

### Editor & Terminal

| Config    | What it does                                                                                 |
| --------- | -------------------------------------------------------------------------------------------- |
| `nvim`    | [LazyVim](https://www.lazyvim.org) — a full IDE setup without the config sprawl              |
| `zed`     | Fast native editor for when you want to stay out of the terminal                             |
| `ghostty` | GPU-accelerated terminal with a sane default config and zero latency                         |
| `tmux`    | Session persistence and window management; TPM handles plugins                               |
| `zellij`  | Multiplexer alternative with a built-in layout system — useful for complex workspace configs |

### TUI Tools

| Config       | What it does                                                                               |
| ------------ | ------------------------------------------------------------------------------------------ |
| `lazygit`    | Git operations without memorizing flags — branches, rebases, and diffs in a single view    |
| `lazydocker` | Container and image management TUI that replaces most `docker` invocations                 |
| `k9s`        | Kubernetes cluster management from the terminal; essential when `kubectl get` isn't enough |
| `yazi`       | Terminal file manager with previews, bulk operations, and plugin support                   |
| `television` | Fuzzy finder built for speed — a ripgrep-powered `fzf` alternative                         |
| `hunk`       | Patch review and staging TUI                                                               |

### System & Productivity

| Config      | What it does                                                                                         |
| ----------- | ---------------------------------------------------------------------------------------------------- |
| `karabiner` | Keyboard remapping at the driver level — complex modifications, home-row mods, layer switching       |
| `mise`      | Runtime version manager for Node, Python, Ruby, and anything else — replaces `nvm`, `rbenv`, `pyenv` |
| `bat`       | `cat` with syntax highlighting, line numbers, and git diff markers                                   |
| `btop`      | System monitor with a layout that actually uses your terminal width                                  |
| `gh`        | Official GitHub CLI — PRs, issues, workflows, and releases from the terminal                         |
| `gh-dash`   | Dashboard TUI for `gh` — all your open PRs and issues in one view                                    |
| `raycast`   | Launcher extensions and scripts                                                                      |
| `sqruff`    | SQL linter and formatter config                                                                      |
| `bucky`     | Local configuration for this setup's custom tooling                                                  |

---

## Fresh machine setup

**Prerequisites:** `brew install stow`

```sh
git clone <repo-url> ~/Developer/personal/dootfiles
```

Before stowing, back up any existing configs that would conflict. Stow refuses to overwrite real files — it errors rather than silently clobbering:

```sh
cd ~/.config
for dir in atuin bat btop bucky fish gh gh-dash ghostty hunk k9s karabiner \
           lazydocker lazygit mise nushell nvim raycast sqruff starship \
           television tmux yazi zed zellij; do
  [ -d "$dir" ] && mv "$dir" "${dir}.bak"
done
```

Then create the symlinks:

```sh
cd ~/Developer/personal/dootfiles
stow --target="$HOME" .
```

That's it. Every tool that reads from `~/.config` will now pick up the versioned config.

> **Verify it worked:** `readlink ~/.config/fish` should print `../Developer/personal/dootfiles/.config/fish`

---

## Stow reference

### Dry run — preview without touching anything

Always run this first on an unfamiliar machine:

```sh
stow -nv --target="$HOME" .
```

Prints every link that _would_ be created or removed. Nothing is changed.

### Stow — create symlinks

```sh
stow --target="$HOME" .
```

Idempotent. Already-correct symlinks are left alone — safe to re-run anytime.

### Restow — sync after changes

```sh
stow --restow --target="$HOME" .
```

Unstow + stow in a single step. Run this after adding a new tool config, renaming a directory, or pulling in someone else's changes.

### Unstow — remove all symlinks

```sh
stow --delete --target="$HOME" .
```

Removes every symlink stow created. Your `.bak` directories are untouched — rename them back to restore the originals.

### Verbose output

```sh
stow --verbose --target="$HOME" .
# combine with dry run:
stow -nv --target="$HOME" .
```

---

## Day-to-day workflows

### Adding a new app's config

Move the existing config into the repo, then restow:

```sh
mv ~/.config/newapp ~/Developer/personal/dootfiles/.config/newapp
cd ~/Developer/personal/dootfiles
stow --restow --target="$HOME" .
```

Then commit the new directory. The symlink is live immediately — no restart needed.

### Removing an app from stow

```sh
# Remove from repo
rm -rf ~/Developer/personal/dootfiles/.config/oldapp

# Clean up the now-dead symlink
stow --restow --target="$HOME" .
```

The app will recreate `~/.config/oldapp` fresh on next launch using its own defaults.

---

## Recovering from conflicts

If stow exits with a `conflicts` error, a real file (not a symlink) exists at the target path. Two options:

```sh
# Option 1: back it up and re-run
mv ~/.config/problem-app ~/.config/problem-app.bak
stow --target="$HOME" .
```

```sh
# Option 2: adopt it — stow moves the file INTO the repo and links back
# Use this only if you want to pull the existing file into your dotfiles
stow --adopt --target="$HOME" .
git diff  # always review before committing — adopt can be destructive
```

> **Note on `--adopt`:** This flag rewrites the file _in your repo_ to match what's on disk. If the on-disk version is worse than what you had committed, you'll overwrite your config. Check `git diff` before you `git add` anything.

---

## Security

**Never commit credentials to this repo.**

API keys, tokens, session cookies, and passwords do not belong here. The right pattern:

- Machine-specific secrets live in a file sourced _outside_ this repo (e.g. `~/.config/fish/local.fish` added to `.gitignore`)
- Long-term secrets belong in a password manager or secrets manager, not in any dotfile
- If you accidentally commit a secret, treat it as compromised immediately — git history is public

---

## Quick cheatsheet

```sh
# Preview what stow will do (always run first)
stow -nv --target="$HOME" .

# Create / update symlinks
stow --target="$HOME" .

# Sync after adding or moving configs
stow --restow --target="$HOME" .

# Remove all symlinks
stow --delete --target="$HOME" .

# Verify a specific symlink
readlink ~/.config/fish
```
