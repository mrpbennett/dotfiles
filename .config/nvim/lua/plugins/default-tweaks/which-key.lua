-- https://github.com/folke/which-key.nvim
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>t", group = "tools", icon = { icon = "󱁤" } },
      },
    },
  },
}
