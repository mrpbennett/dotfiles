vim.pack.add({
  { src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,

    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "snacks_layout_box",
      },
    },
  },
})

local map = vim.keymap.set

map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
map("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
map("n", "[B", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer prev" })
map("n", "]B", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next" })
map("n", "<leader>bj", "<Cmd>BufferLinePick<CR>", { desc = "Pick Buffer" })
