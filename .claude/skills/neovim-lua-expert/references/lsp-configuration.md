# LSP Configuration

## Architecture Overview

```
mason.nvim          → Installs LSP servers, formatters, linters
mason-lspconfig     → Bridges mason ↔ lspconfig (auto-setup)
nvim-lspconfig      → Configures and launches LSP servers
blink.cmp / cmp     → Provides completion capabilities to LSP
```

## Standard Setup Pattern (with mason)

```lua
-- 1. Mason installs servers
require("mason").setup()

-- 2. mason-lspconfig bridges the gap
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "pyright" },
  handlers = {
    -- Default handler for all servers
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities, -- from completion plugin
      })
    end,
    -- Override for specific server
    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          },
        },
      })
    end,
  },
})
```

## Capabilities Setup

### With blink.cmp
```lua
local capabilities = require("blink.cmp").get_lsp_capabilities()
```

### With nvim-cmp
```lua
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
```

## on_attach Pattern

```lua
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gr", vim.lsp.buf.references, "Goto References")
    map("gI", vim.lsp.buf.implementation, "Goto Implementation")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

    -- Highlight references on cursor hold
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
```

## Diagnostics Configuration

```lua
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = true },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
  virtual_text = {
    source = true,
    spacing = 2,
  },
})
```

## Formatting (conform.nvim)

```lua
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
```

## Debugging Checklist

1. `:LspInfo` — server running? attached to buffer?
2. `:LspLog` — server errors? (`vim.lsp.set_log_level("debug")` for verbose)
3. `:Mason` — server installed? correct version?
4. `:checkhealth lsp` — general health
5. `vim.lsp.get_clients({ bufnr = 0 })` — programmatic check
6. Verify filetype: `:set ft?` — must match lspconfig's `filetypes`
7. Verify root dir: does the project have the expected root markers (`.git`, `package.json`, etc.)?
