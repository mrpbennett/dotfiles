-- https://github.com/catppuccin/nvim
-- https://github.com/booberrytheme/boo-berry.nvim
-- https://github.com/Mofiqul/dracula.nvim
return {
  -- dracula
  { "Mofiqul/dracula.nvim", lazy = true },
  -- boo-berry
  { "mrpbennett/boo-berry.nvim", lazy = true },
  -- gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = true },
  -- vault
  { "mrpbennett/vault", lazy = true },
  -- everforest
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "auto",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      term_colors = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
}
