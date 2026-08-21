-- Prepend mise shims to PATH so LSP servers, linters and formatters
-- resolve through mise even when nvim is launched outside a mise shell.
-- https://mise.jdx.dev/ide-integration.html#neovim
local mise_shims = vim.env.HOME .. "/.local/share/mise/shims"
if vim.uv.fs_stat(mise_shims) and not vim.env.PATH:find(mise_shims, 1, true) then
  vim.env.PATH = mise_shims .. ":" .. vim.env.PATH
end

-- Prevent vim-dadbod from remapping trino:// → presto:// so our custom
-- adapter and schema support are used. Must be set before lazy loads dadbod.
vim.g.db_adapters = { trino = "trino" }

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.db_adapter_trino = "db#adapter#trino#"
