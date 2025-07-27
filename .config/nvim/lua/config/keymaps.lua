-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("i", "jj", "<Esc>", opts)
vim.api.nvim_set_keymap("i", "jk", "<Esc>", opts)

-- Move lines up and down
-- Normal
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Visual
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Insert
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
