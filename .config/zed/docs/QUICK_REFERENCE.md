# LazyVim → Zed Quick Reference Card

A cheat sheet for the most commonly used keybindings.

## Essential Mappings

### Leader Key = `Space`

## 🚀 Most Used Commands

| Key | Action |
|-----|--------|
| `<leader>ff` | Find file (file picker) |
| `<leader><space>` | Find file (quick) |
| `<leader>fg` | Search in project (grep) |
| `<leader>/` | Search in project |
| `<leader>e` | Toggle file explorer |
| `<leader>gg` | Git panel |

## 📂 Buffer Management

| Key | Action |
|-----|--------|
| `Shift-H` | Previous buffer |
| `Shift-L` | Next buffer |
| `<leader>bd` | Close buffer |
| `<leader>bo` | Close other buffers |
| `<leader>bb` | Alternate buffer (last) |

## 🪟 Window Navigation

| Key | Action |
|-----|--------|
| `Ctrl-h` | Left pane |
| `Ctrl-j` | Lower pane |
| `Ctrl-k` | Upper pane |
| `Ctrl-l` | Right pane |
| `<leader>-` | Split horizontal |
| `<leader>\|` | Split vertical |
| `<leader>wd` | Close pane |

## 📝 Code Editing

| Key | Action |
|-----|--------|
| `Alt-j` | Move line down |
| `Alt-k` | Move line up |
| `Ctrl-s` | Save file |
| `<` / `>` | Indent left/right (visual) |
| `jk` | Escape to normal (insert) |

## 🔍 LSP & Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to type definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format code |
| `K` | Hover documentation |

## 🐛 Diagnostics

| Key | Action |
|-----|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>cd` | Show diagnostics |
| `<leader>xx` | Diagnostics panel |

## 🔍 Search

| Key | Action |
|-----|--------|
| `/` | Buffer search |
| `n` | Next match |
| `N` | Previous match |
| `Esc` | Clear highlight |

## 📦 Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Git panel |
| `<leader>gb` | Git blame |
| `<leader>gB` | Git browse |

## 💻 Terminal

| Key | Action |
|-----|--------|
| `<leader>ft` | Toggle terminal |
| `Ctrl-/` | Toggle terminal (quick) |
| `Esc Esc` | Terminal normal mode |

## 🎨 UI Toggles

| Key | Action |
|-----|--------|
| `<leader>uw` | Toggle wrap |
| `<leader>ul` | Toggle line numbers |
| `<leader>ud` | Toggle diagnostics |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ug` | Toggle git blame |

## 🔧 Vim Window Commands

| Key | Action |
|-----|--------|
| `Ctrl-w h/j/k/l` | Navigate panes |
| `Ctrl-w v` | Split vertical |
| `Ctrl-w s` | Split horizontal |
| `Ctrl-w c` | Close pane |
| `Ctrl-w o` | Close other panes |

## 📋 Symbols & Outline

| Key | Action |
|-----|--------|
| `<leader>ss` | Document symbols (outline) |
| `<leader>sS` | Workspace symbols |

## 🎯 Tab Management

| Key | Action |
|-----|--------|
| `<leader><tab>]` | Next tab |
| `<leader><tab>[` | Previous tab |
| `<leader><tab>d` | Close tab |
| `<leader><tab>o` | Close other tabs |

## ⚙️ System

| Key | Action |
|-----|--------|
| `<leader>qq` | Quit Zed |
| `<leader>l` | Extensions (plugins) |
| `Cmd/Ctrl-Shift-P` | Command palette |

## 💡 Tips

1. **Leader Key Timeout**: Wait ~1 second after `Space` for multi-key sequences
2. **Vim Mode Required**: Enable in settings for leader bindings to work
3. **Context Matters**: Some keys behave differently in Normal vs Visual mode
4. **Escape Options**: Use `Esc` or `jk` to exit Insert mode
5. **Help**: Use Command Palette (`Cmd/Ctrl-Shift-P`) to discover actions

## Common Workflows

### Open a file and edit
```
<leader>ff       → Find file
<leader>e        → Open file tree (alternative)
```

### Search in project
```
<leader>fg       → Project search
<leader>/        → Project search (alternative)
```

### Navigate code
```
gd               → Go to definition
gr               → Find references
<leader>ca       → Code actions
<leader>cr       → Rename
```

### Git workflow
```
<leader>gg       → Open Git panel
<leader>gb       → Toggle blame
<leader>gB       → Browse in browser
```

### Window management
```
<leader>|        → Split vertical
<leader>-        → Split horizontal
Ctrl-h/j/k/l     → Navigate panes
<leader>wd       → Close pane
```

### Buffer management
```
<leader>ff       → Open new buffer
Shift-H/L        → Switch buffers
<leader>bd       → Close buffer
<leader>bb       → Last buffer
```

---

**Print this page for quick reference!** 🎯

For complete documentation, see [LAZYVIM_KEYBINDS.md](./LAZYVIM_KEYBINDS.md)
