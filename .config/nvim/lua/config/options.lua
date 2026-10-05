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

-- ignore editorconfig end_of_line so existing files keep their line endings
require("editorconfig").properties.end_of_line = nil

-- disable format-on-save for shared work repos, except my own (toggle per buffer with <leader>uF)
-- lives here, not autocmds.lua, so it also applies to the file passed on the command line
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = vim.fn.expand("~") .. "/Work/*",
  callback = function(args)
    if not args.match:find("/pbennett-monorepo/", 1, true) then
      vim.b[args.buf].autoformat = false
    end
  end,
})
