return {
  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false, 
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    enable_git_status = true,
      enable_diagnostics = true,

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          never_show = { ".DS_Store", "thumbs.db" },
        },
      }
  },
}
}