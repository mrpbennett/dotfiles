-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
--
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("sql_indent", { clear = true }),
  pattern = "sql",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- AutoSave on focus/buffer leave
local autosave = vim.api.nvim_create_augroup("autosave", { clear = true })
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = autosave,
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

-- Stop return on commented lines creating commented lines
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})
