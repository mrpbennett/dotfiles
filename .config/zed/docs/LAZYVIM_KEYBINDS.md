# LazyVim Keybindings for Zed

A comprehensive drop-in replacement for LazyVim keybindings in Zed editor. This configuration replicates the LazyVim keyboard shortcuts to provide a familiar experience when using Zed with Vim mode.

## Installation

1. **Backup your existing keybindings** (if any):
   ```bash
   cp ~/.config/zed/keymap.json ~/.config/zed/keymap.json.backup
   ```

2. **Copy the keymap file**:
   ```bash
   cp keymap.json ~/.config/zed/keymap.json
   ```

3. **Enable Vim mode in Zed**:
   Open Zed settings (`cmd-,` or `ctrl-,`) and add:
   ```json
   {
     "vim_mode": true,
     "vim": {
       "use_system_clipboard": "always",
       "use_smartcase_find": true,
       "toggle_relative_line_numbers": true
     }
   }
   ```

4. **Restart Zed** to apply the changes

## Leader Key

In LazyVim, `<leader>` is typically `Space`. This configuration uses `space` as the leader key in Zed's Vim mode.

## Keybinding Categories

### Navigation & Movement

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `j` / `k` | Normal/Visual | Move down/up | Visual line navigation |
| `<Down>` / `<Up>` | Normal/Visual | Move down/up | Visual line navigation |

### Window Management

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `Ctrl-h` | Normal | Go to left pane | |
| `Ctrl-j` | Normal | Go to lower pane | |
| `Ctrl-k` | Normal | Go to upper pane | |
| `Ctrl-l` | Normal | Go to right pane | |
| `Ctrl-Up` | Normal | Increase window height | Resize up |
| `Ctrl-Down` | Normal | Decrease window height | Resize down |
| `Ctrl-Left` | Normal | Decrease window width | Resize left |
| `Ctrl-Right` | Normal | Increase window width | Resize right |
| `<leader>-` | Normal | Split window below | Horizontal split |
| `<leader>\|` | Normal | Split window right | Vertical split |
| `<leader>wd` | Normal | Delete window | Close pane |
| `Ctrl-w h/j/k/l` | Normal | Navigate panes | Vim-style window nav |
| `Ctrl-w v` | Normal | Split vertically | |
| `Ctrl-w s` | Normal | Split horizontally | |
| `Ctrl-w c` | Normal | Close window | |
| `Ctrl-w o` | Normal | Close other windows | |

### Line Movement

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `Alt-j` | Normal/Insert/Visual | Move line down | Supports visual selection |
| `Alt-k` | Normal/Insert/Visual | Move line up | Supports visual selection |

### Buffer Management

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `Shift-h` | Normal | Previous buffer | |
| `Shift-l` | Normal | Next buffer | |
| `[b` | Normal | Previous buffer | |
| `]b` | Normal | Next buffer | |
| `<leader>bb` | Normal | Switch to alternate buffer | Last buffer |
| `<leader>`` | Normal | Switch to alternate buffer | Backtick |
| `<leader>bd` | Normal | Delete buffer | Close tab |
| `<leader>bo` | Normal | Delete other buffers | Close inactive tabs |
| `<leader>bD` | Normal | Delete buffer and window | Force close |

### Search & Highlight

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `Esc` | Normal | Clear search highlight | |
| `Esc` | Insert | Exit to normal mode | |
| `n` | Normal/Visual | Next search result | |
| `N` | Normal/Visual | Previous search result | |
| `/` | Normal | Buffer search | Open search dialog |

### Editing

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `Ctrl-s` | All | Save file | Works in all modes |
| `<` | Visual | Indent left | Maintains selection |
| `>` | Visual | Indent right | Maintains selection |
| `gco` | Normal | Add comment below | |
| `gcO` | Normal | Add comment above | |
| `jk` | Insert | Escape to normal mode | Fast escape alternative |

### Formatting & LSP

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>cf` | Normal | Format code | Force format |
| `<leader>K` | Normal | Hover documentation | Show docs |
| `K` | Normal | Hover documentation | Standard Vim binding |
| `<leader>ca` | Normal | Code actions | Quick fix menu |
| `<leader>cr` | Normal | Rename symbol | LSP rename |
| `gd` | Normal | Go to definition | |
| `gD` | Normal | Go to type definition | |
| `gr` | Normal | Find references | |
| `gi` | Normal | Go to implementation | |

### Diagnostics

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>cd` | Normal | Show line diagnostics | Open diagnostics panel |
| `<leader>xx` | Normal | Show all diagnostics | Diagnostics panel |
| `]d` | Normal | Next diagnostic | |
| `[d` | Normal | Previous diagnostic | |
| `]e` | Normal | Next error | |
| `[e` | Normal | Previous error | |
| `]w` | Normal | Next warning | |
| `[w` | Normal | Previous warning | |

### Quickfix & Location List

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>xl` | Normal | Toggle location list | Diagnostics panel |
| `<leader>xq` | Normal | Toggle quickfix | Diagnostics panel |
| `[q` | Normal | Previous quickfix | |
| `]q` | Normal | Next quickfix | |

### Git Operations

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>gg` | Normal | Open Git panel | Lazygit equivalent |
| `<leader>gG` | Normal | Open Git panel (cwd) | |
| `<leader>gb` | Normal | Git blame | Toggle blame |
| `<leader>gB` | Normal | Git browse | Open in browser |

### Toggle Options

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>uw` | Normal | Toggle wrap | Soft wrap |
| `<leader>uL` | Normal | Toggle relative line numbers | |
| `<leader>ul` | Normal | Toggle line numbers | |
| `<leader>ud` | Normal | Toggle diagnostics | |
| `<leader>uh` | Normal | Toggle inlay hints | LSP hints |
| `<leader>ug` | Normal | Toggle git blame | |

### Terminal

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>ft` | Normal | Toggle terminal | Root directory |
| `<leader>fT` | Normal | Toggle terminal | Current directory |
| `Ctrl-/` | Normal/Terminal | Toggle terminal | Quick toggle |
| `Ctrl-_` | Normal/Terminal | Toggle terminal | Alternative |
| `Esc Esc` | Terminal | Terminal normal mode | Exit insert mode |

### Tabs

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader><tab>l` | Normal | Last tab | |
| `<leader><tab>o` | Normal | Close other tabs | |
| `<leader><tab>f` | Normal | First tab | |
| `<leader><tab><tab>` | Normal | New tab | |
| `<leader><tab>]` | Normal | Next tab | |
| `<leader><tab>d` | Normal | Close tab | |
| `<leader><tab>[` | Normal | Previous tab | |

### File Operations

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>fn` | Normal | New file | |
| `<leader>ff` | Normal | Find file | File finder |
| `<leader><space>` | Normal | Find file | Quick file finder |
| `<leader>fr` | Normal | Recent files | |
| `<leader>fg` | Normal | Project search | Grep/ripgrep |
| `<leader>/` | Normal | Project search | Alternative |

### Project Navigation

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>e` | Normal | Toggle file explorer | Project panel |
| `<leader>E` | Normal | Toggle file explorer | Alternative |

### Search & Symbols

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>ss` | Normal | Document symbols | Outline |
| `<leader>sS` | Normal | Workspace symbols | Project symbols |

### System & Quit

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>qq` | Normal | Quit all | Exit Zed |

### Command Palette

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `Cmd-Shift-P` | All | Command palette | macOS |
| `Ctrl-Shift-P` | All | Command palette | Windows/Linux |

### Plugin Manager

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>l` | Normal | Extensions | Lazy.nvim equivalent |

### Misc

| Key | Mode | Action | Notes |
|-----|------|--------|-------|
| `<leader>ur` | Normal | Redraw & clear | Cancel/refresh |
| `<leader>ui` | Normal | Inspect position | Hover info |
| `<leader>cd` | Normal | Duplicate line | |
| `<leader>dl` | Normal | Delete line | |
| `p` | Visual | Paste | Without yanking |

## Differences from LazyVim

Due to Zed's architecture and feature set, some LazyVim keybindings cannot be exactly replicated:

### Not Available in Zed

1. **Undo break-points** (`,`, `.`, `;` in insert mode) - Zed handles undo differently
2. **Window zoom toggle** (`<leader>wm`, `<leader>uZ`) - No zoom feature
3. **Zen mode** (`<leader>uz`) - No zen mode (yet)
4. **Conceal level** (`<leader>uc`) - Not applicable
5. **Background toggle** (`<leader>ub`) - Use Zed settings
6. **Treesitter toggle** (`<leader>uT`) - Different syntax system
7. **Tabline toggle** (`<leader>uA`) - UI controlled by settings
8. **Dim toggle** (`<leader>uD`) - Not available
9. **Animations toggle** (`<leader>ua`) - Settings-based
10. **Smooth scroll toggle** (`<leader>uS`) - Settings-based
11. **Indent guides toggle** (`<leader>ug`) - Mapped to git blame instead
12. **Debug profiler** (`<leader>dpp`, `<leader>dph`) - Different debugging approach
13. **LazyVim changelog** (`<leader>L`) - Not applicable
14. **Snacks.lua integrations** - Zed has different plugin architecture

### Different Behavior

1. **Better n/N search** - Zed doesn't support centering on search with `zv`
2. **Expression mappings** - `j`/`k` behavior slightly different (no `v:count` support)
3. **Lazy.nvim** - Mapped to Zed Extensions instead (`<leader>l`)
4. **Git integrations** - Limited to built-in Git features
5. **Lazygit** - Opens Zed's git panel instead of external tool
6. **Lua development bindings** - Not applicable (Zed doesn't use Lua)

### Partially Supported

1. **Which-key groups** - Zed doesn't have which-key, but key sequences work
2. **Git operations** - Basic support through Zed's Git integration
3. **Diagnostic navigation** - Slightly different from Neovim's implementation
4. **Format on save** - Controlled via Zed settings, not keybinding toggle

## Tips

1. **Learning the bindings**: Use Zed's command palette (`Cmd/Ctrl-Shift-P`) to discover available actions
2. **Customization**: Edit `~/.config/zed/keymap.json` to customize further
3. **Conflicts**: If you experience keybinding conflicts, check Zed's default keybindings
4. **Vim mode**: Ensure Vim mode is enabled for leader key bindings to work
5. **Platform differences**: Some bindings use `Cmd` on macOS and `Ctrl` on Windows/Linux

## Troubleshooting

### Keybindings not working

1. Ensure Vim mode is enabled in settings
2. Restart Zed after installing the keymap
3. Check for JSON syntax errors in `keymap.json`
4. Verify file location: `~/.config/zed/keymap.json`

### Leader key not working

1. Ensure you're in Normal or Visual mode (not Insert mode)
2. Wait briefly after pressing Space to complete the key sequence
3. Check that `vim_mode: true` is set in settings

### Conflicts with default bindings

1. Check Zed's default keybindings: `Cmd-K Cmd-S` (macOS) or `Ctrl-K Ctrl-S` (Windows/Linux)
2. Your custom keybindings override defaults
3. Set unwanted default bindings to `null` to disable them

## Contributing

Found an issue or have a suggestion? The keymap was generated based on:
- LazyVim source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
- Zed keybindings docs: https://zed.dev/docs/key-bindings
- Zed Vim mode docs: https://zed.dev/docs/vim

## Resources

- [Zed Documentation](https://zed.dev/docs)
- [LazyVim Documentation](https://www.lazyvim.org/)
- [Zed Key Bindings Reference](https://zed.dev/docs/key-bindings)
- [Zed Vim Mode Reference](https://zed.dev/docs/vim)
- [Zed All Actions](https://zed.dev/docs/all-actions)

## License

This configuration is provided as-is for the community. Feel free to modify and share.
