# Plugin Management — lazy.nvim

## Spec Format

```lua
{
  "author/plugin-name",          -- short GitHub URL
  dependencies = { "dep/repo" }, -- loaded before this plugin
  event = "BufReadPost",         -- lazy-load on event
  ft = { "lua", "python" },     -- lazy-load on filetype
  cmd = "Telescope",             -- lazy-load on command
  keys = {                       -- lazy-load on keymap
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  },
  opts = {},                     -- passed to plugin.setup(opts)
  config = function(_, opts)     -- custom setup (receives opts)
    require("plugin").setup(opts)
  end,
  init = function()              -- runs at startup (before load)
    -- set globals, keymaps for lazy-loaded plugins
  end,
  enabled = true,                -- false to disable without removing
  cond = function()              -- conditional loading (checked at startup)
    return vim.fn.executable("rg") == 1
  end,
  priority = 1000,               -- load order (higher = earlier, default 50)
  lazy = true,                   -- explicit lazy loading
  build = ":TSUpdate",           -- post-install/update command
}
```

## Load Order

1. Plugins with `priority` set (highest first) — colorschemes should use `priority = 1000`
2. Plugins with `lazy = false` (in dependency order)
3. Lazy-loaded plugins (when their trigger fires)

## Key Patterns

### Splitting Config Across Files

```
lua/
  plugins/
    init.lua        -- returns list of specs or require sub-modules
    lsp.lua         -- LSP-related plugins
    editor.lua      -- editing plugins
    ui.lua          -- UI plugins
```

lazy.nvim can import directories:
```lua
require("lazy").setup({
  { import = "plugins" },        -- imports all files in lua/plugins/
  { import = "custom.plugins" }, -- imports lua/custom/plugins/
})
```

### Extending Plugin Specs

When a plugin is defined in multiple files, lazy.nvim merges specs:
```lua
-- In plugins/core.lua
{ "nvim-telescope/telescope.nvim", cmd = "Telescope" }

-- In plugins/extensions.lua (adds to the same plugin)
{ "nvim-telescope/telescope.nvim", opts = { defaults = { layout = "horizontal" } } }
```

### Overriding Kickstart Defaults

To override a plugin from kickstart without modifying the original:
```lua
-- In lua/custom/plugins/override.lua
return {
  {
    "plugin/name",
    opts = { -- these get merged with kickstart's opts
      new_option = true,
    },
  },
}
```

## Common Issues

- **Plugin not loading**: Check `event`, `ft`, `cmd`, `keys` triggers — they must match exactly
- **Wrong load order**: Use `dependencies` or `priority`, not file naming
- **opts not applied**: If using `config`, you must call `setup(opts)` yourself
- **Build failing**: Check `:Lazy log` for build output
