# Keymaps & Which-Key

## vim.keymap.set

```lua
-- Basic usage
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- Multiple modes
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- Lua function callback
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostics" })

-- Buffer-local
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover docs" })

-- Options
vim.keymap.set("n", "<leader>x", func, {
  desc = "Description",     -- shown in which-key
  buffer = bufnr,           -- buffer-local (number or true)
  silent = true,            -- default: true
  noremap = true,           -- default: true
  expr = false,             -- return value used as mapping
  nowait = false,           -- don't wait for longer mappings
})
```

## Modes

| Mode | String | Description |
|------|--------|-------------|
| Normal | `"n"` | Default mode |
| Insert | `"i"` | Typing text |
| Visual | `"v"` | Visual + Visual Line |
| Visual only | `"x"` | Visual only (not Select) |
| Select | `"s"` | Select mode |
| Command | `"c"` | Command-line mode |
| Terminal | `"t"` | Terminal mode |
| Operator-pending | `"o"` | After operator (d, y, c) |

## which-key.nvim Integration

### Registering Groups

```lua
require("which-key").add({
  { "<leader>c", group = "Code" },
  { "<leader>s", group = "Search" },
  { "<leader>g", group = "Git" },
  { "<leader>d", group = "Debug" },
  { "<leader>t", group = "Toggle" },
})
```

### Registering Keys with which-key

```lua
require("which-key").add({
  { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  -- Hidden from which-key popup
  { "<leader>x", hidden = true },
})
```

## Conflict Resolution

### Finding Conflicts

```vim
" Find where a mapping was set
:verbose nmap <leader>f

" List all normal mode mappings
:nmap

" Programmatic inspection
:lua =vim.inspect(vim.api.nvim_get_keymap("n"))

" Buffer-local mappings
:lua =vim.inspect(vim.api.nvim_buf_get_keymap(0, "n"))
```

### Common Conflict Patterns

1. **Plugin overrides your mapping**: Plugin loads after your keymap. Fix: use `init` (runs before load) or set in `LspAttach` autocmd.
2. **Two plugins want same key**: One wins based on load order. Fix: override in one plugin's `keys` spec.
3. **Buffer-local vs global**: Buffer-local always wins. Check with `:verbose map`.
4. **`<leader>` not set**: Must set `vim.g.mapleader` before `lazy.setup()`.

## Recommended Leader Key Layout

```
<leader>
├── b  → Buffers
├── c  → Code (LSP actions)
├── d  → Debug
├── e  → Explorer
├── f  → Find/Files
├── g  → Git
├── h  → Hunk (git)
├── l  → LSP info
├── q  → Quit/Session
├── r  → Rename/Replace
├── s  → Search (Telescope)
├── t  → Toggle
├── w  → Window
├── x  → Diagnostics/Trouble
```
