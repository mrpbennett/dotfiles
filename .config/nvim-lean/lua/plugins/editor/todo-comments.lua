vim.pack.add({
  "https://github.com/folke/todo-comments.nvim",
})

require("todo-comments").setup()

local map = vim.keymap.set

map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })
map("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
map("n", "<leader>st", function()
  vim.cmd.TodoQuickFix()
  Snacks.picker.qflist()
end, { desc = "Todo" })
map("n", "<leader>sT", function()
  vim.cmd("TodoQuickFix keywords=TODO,FIX,FIXME")
  Snacks.picker.qflist()
end, { desc = "Todo/Fix/Fixme" })
