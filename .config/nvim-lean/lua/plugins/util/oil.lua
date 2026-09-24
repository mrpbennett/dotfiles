vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
})

require("oil").setup({
  delete_to_trash = true,
  watch_for_changes = true,
  view_options = {
    show_hidden = true
  }
})

local map = vim.keymap.set

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
