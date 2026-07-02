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
  -- Auto dark/light mode switching based on macOS appearance
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      set_dark_mode = function()
        vim.cmd.colorscheme("catppuccin-macchiato")
      end,
      set_light_mode = function()
        vim.cmd.colorscheme("catppuccin-latte")
      end,
    },
  },
}
