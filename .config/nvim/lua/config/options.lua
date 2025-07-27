-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- python liniter
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

-- relative numbers
vim.wo.relativenumber = true
-- disable swap
-- vim.opt.swapfile = false

-- disable comments on new lines
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
})

vim.g.lazyvim_prettier_needs_config = false -- Prettier
vim.g.lazyvim_eslint_auto_format = true -- ESLint
