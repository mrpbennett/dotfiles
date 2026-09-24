vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "x" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>c",     group = "code" },
      { "<leader>d",     group = "debug" },
      { "<leader>dp",    group = "profiler" },
      { "<leader>f",     group = "file/find" },
      { "<leader>g",     group = "git" },
      { "<leader>gh",    group = "hunks" },
      { "<leader>q",     group = "quit/session" },
      { "<leader>s",     group = "search" },
      { "<leader>u",     group = "ui" },
      { "<leader>x",     group = "diagnostics/quickfix" },
      { "[",             group = "prev" },
      { "]",             group = "next" },
      { "g",             group = "goto" },
      { "gs",            group = "surround" },
      { "z",             group = "fold" },
      {
        "<leader>b",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      {
        "<leader>w",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
      -- better descriptions
      { "gx", desc = "Open with system app" },
    },
  },
})

local map = vim.keymap.set


map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Keymaps (which-key)" })
map("n", "<C-w><Space>", function()
  require("which-key").show({ keys = "<C-w>", loop = true })
end, { desc = "Window Hydra Mode (which-key)" })
