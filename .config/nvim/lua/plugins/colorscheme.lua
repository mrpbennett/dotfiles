-- https://github.com/catppuccin/nvim
-- https://github.com/booberrytheme/boo-berry.nvim
-- https://github.com/Mofiqul/dracula.nvim
return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "auto",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
          ok = { "undercurl" },
        },
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        snacks = { enabled = true },
        telescope = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.special.bufferline").get_theme()
          end
        end,
      },
    },
  },

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
  --
  -- Set Theme here:
  -- opts:
  --  catppuccin
  --  dracula
  --  boo-berry
  --  gruvbox
  --  vault
  --  everforest
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = vim.o.background == "dark" and "catppuccin-macchiato" or "catppuccin-latte",
    },
  },
}
