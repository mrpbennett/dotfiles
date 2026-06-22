<h1 align="center">
    <img src="assets/mascot.png" width="300" alt="Bucky logo"/>
    <br/>
    <sub>Collection of configuration files</sub>
</h1>

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's in here

All configs live under `.config/` and cover:

| Tool                     | Purpose                                   |
| ------------------------ | ----------------------------------------- |
| `fish`                   | Shell + functions/completions             |
| `nvim`                   | [LazyVim](https://www.lazyvim.org) config |
| `tmux`                   | Multiplexer + TPM plugins                 |
| `zed`                    | Editor                                    |
| `ghostty`                | Terminal emulator                         |
| `zellij`                 | Terminal multiplexer (alt)                |
| `starship`               | Shell prompt                              |
| `atuin`                  | Shell history sync                        |
| `yazi`                   | File manager                              |
| `lazygit` / `lazydocker` | Git / Docker TUIs                         |
| `k9s`                    | Kubernetes TUI                            |
| `karabiner`              | Keyboard remapping                        |
| `mise`                   | Runtime version manager                   |
| `bat` / `btop`           | `cat` replacement / system monitor        |
| `gh` / `gh-dash`         | GitHub CLI + dashboard                    |
| `raycast`                | Launcher extensions                       |
| `television`             | Fuzzy finder                              |
| `nushell`                | Nu shell config                           |

## Install (fresh machine)

**Prerequisites:** `brew install stow`

```sh
git clone <repo-url> ~/Developer/personal/dootfiles
cd ~/Developer/personal/dootfiles
```

Back up any existing configs that would conflict (stow errors rather than overwrites):

```sh
# Batch rename every matching dir to .bak
cd ~/.config
for dir in atuin bat btop bucky fish gh gh-dash ghostty hunk k9s karabiner \
           lazydocker lazygit mise nushell nvim raycast sqruff starship \
           television tmux yazi zed zellij; do
  [ -d "$dir" ] && mv "$dir" "${dir}.bak"
done
```

Then stow:

```sh
cd ~/Developer/personal/dootfiles
stow --target="$HOME" .
```

## Stow command reference

### Dry run — preview before touching anything

```sh
stow --simulate --target="$HOME" .
# short form
stow -nv --target="$HOME" .
```

Always run this first if you're unsure. It prints what *would* happen without making any changes.

### Stow (create symlinks)

```sh
stow --target="$HOME" .
```

Stow is idempotent — safe to re-run anytime. Already-correct symlinks are left alone.

### Restow — use after adding or moving configs

```sh
stow --restow --target="$HOME" .
```

Equivalent to unstow + stow in one step. Use this whenever you add a new tool or rename something.

### Unstow — remove all symlinks

```sh
stow --delete --target="$HOME" .
```

Removes every symlink stow created. Your original `.bak` dirs are untouched — rename them back to restore.

### Verbose — see exactly what stow is doing

```sh
stow --verbose --target="$HOME" .
# or combine with dry run
stow -nv --target="$HOME" .
```

### Verify a symlink is correct

```sh
readlink ~/.config/fish
# should print: ../Developer/personal/dootfiles/.config/fish
```

## Adding a new app's config

```sh
mv ~/.config/newapp ~/Developer/personal/dootfiles/.config/newapp
cd ~/Developer/personal/dootfiles
stow --restow --target="$HOME" .
```

Then commit the new directory.

## Removing an app's config from stow

```sh
# Remove from repo
rm -rf ~/Developer/personal/dootfiles/.config/oldapp

# Restow to clean up the dead symlink
stow --restow --target="$HOME" .

# The app will recreate ~/.config/oldapp fresh on next launch
```

## Recovering from conflicts

If stow errors with `conflicts`, it means a real file (not a symlink) exists at the target. Options:

```sh
# Option 1: back it up and re-run
mv ~/.config/problem-app ~/.config/problem-app.bak
stow --target="$HOME" .

# Option 2: adopt it (stow moves the file INTO the repo and links back)
# Only use this if you want to capture the existing file into your dotfiles
stow --adopt --target="$HOME" .
git diff  # review what was pulled in before committing
```

## Security note

**Never commit credentials to this repo.** Files with secrets (API keys, tokens, passwords) belong in `.gitignore`. Use a secrets manager or per-machine env files sourced outside this repo instead.
