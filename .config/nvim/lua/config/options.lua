-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.inccommand = "split" -- better search window

-- set terminal to use zsh
vim.opt.shell = vim.fn.exepath("zsh")

-- stop auto comments
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- python lazyvim
vim.g.lazyvim_python_lsp = "ty"

-- disable the option to require prettier config file
vim.g.lazyvim_prettier_needs_config = false
