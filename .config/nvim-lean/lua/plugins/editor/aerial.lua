vim.pack.add({
  "https://github.com/stevearc/aerial.nvim",
})

require("aerial").setup({
  backends = { "lsp", "treesitter", "markdown", "man" },
  layout = { min_width = 28 },
  show_guides = true,
  filter_kind = false,
  guides = {
    mid_item = "├─",
    last_item = "└─",
    nested_top = "│ ",
    whitespace = "  ",
  },
})

vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle!<cr>", { desc = "Aerial (Symbols)" })
