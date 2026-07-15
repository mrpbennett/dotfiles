# Treesitter

## Setup

```lua
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
```

## Textobjects (nvim-treesitter-textobjects)

```lua
require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
    swap = {
      enable = true,
      swap_next = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },
  },
})
```

## Debugging

| Command | Purpose |
|---------|---------|
| `:TSModuleInfo` | Shows which modules are enabled per language |
| `:TSInstallInfo` | Shows installed parsers |
| `:TSUpdate` | Update all parsers |
| `:TSHighlightCapturesUnderCursor` | Debug highlighting |
| `:InspectTree` | Open treesitter AST viewer (Neovim 0.10+) |
| `:checkhealth treesitter` | Health check |

## Common Issues

- **Highlighting flickers**: Usually a conflict with `vim.syntax` — try `additional_vim_regex_highlighting = false`
- **Parser not installed**: Run `:TSInstall <lang>` or add to `ensure_installed`
- **Indent broken**: Some parsers have immature indent support — disable per-language: `indent = { enable = true, disable = { "python" } }`
- **Slow on large files**: Treesitter parses the full buffer. Use `disable` function to skip large files:
  ```lua
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      return ok and stats and stats.size > max_filesize
    end,
  },
  ```
