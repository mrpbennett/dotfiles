-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- floating terminal
map("n", "<leader>fo", function()
  Snacks.terminal(nil, {
    win = {
      style = "float",
      border = "rounded",
      title = " Terminal ",
      title_pos = "center",
    },
  })
end, { desc = "Terminal (floating)" })

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- hunk diff
map("n", "<leader>ohd", function()
  Snacks.terminal("hunk diff")
end, { desc = "Hunk Diff" })

map("n", "<leader>ohm", function()
  Snacks.terminal("hunk diff origin/main")
end, { desc = "Hunk Diff - origin/main" })

vim.keymap.set("n", "<leader>mc", function()
  local mc_ns = vim.api.nvim_create_namespace("nvim.multicursor")
  vim.api.nvim_buf_clear_namespace(0, mc_ns, 0, -1)
  vim.cmd("nohlsearch")
  vim.cmd("redraw!")
end, { desc = "Clear Native Multicursors" })
