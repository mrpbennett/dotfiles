# Completion Engines

## blink.cmp

Modern, high-performance completion plugin written in Rust.

### Basic Setup

```lua
{
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*", -- use releases for stability
  opts = {
    keymap = { preset = "default" },
    appearance = {
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
  },
}
```

### LSP Capabilities Integration

```lua
-- In your LSP setup, get capabilities from blink:
local capabilities = require("blink.cmp").get_lsp_capabilities()
require("lspconfig").lua_ls.setup({ capabilities = capabilities })
```

### Custom Keymap

```lua
keymap = {
  ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  ["<C-e>"] = { "hide" },
  ["<CR>"] = { "accept", "fallback" },
  ["<Tab>"] = { "snippet_forward", "fallback" },
  ["<S-Tab>"] = { "snippet_backward", "fallback" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<C-p>"] = { "select_prev", "fallback" },
  ["<C-n>"] = { "select_next", "fallback" },
  ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  ["<C-f>"] = { "scroll_documentation_down", "fallback" },
},
```

### Source Configuration

```lua
sources = {
  default = { "lsp", "path", "snippets", "buffer" },
  per_filetype = {
    sql = { "snippets", "dadbod", "buffer" },
  },
  providers = {
    dadbod = {
      name = "Dadbod",
      module = "vim_dadbod_completion.blink",
    },
  },
},
```

## nvim-cmp (Legacy but Widely Used)

### Basic Setup

```lua
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  },
})
```

## Debugging Completion

1. **No completions appearing**: Check `:LspInfo` — is an LSP attached? Are capabilities passed?
2. **Source not working**: Verify the source plugin is installed and loaded
3. **blink.cmp specific**: Check `:checkhealth blink-cmp`
4. **Slow completions**: LSP server may be slow — check `:LspLog`
