return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      columns = {
        "icon",
      },
      delete_to_trash = true,
      view_options = { show_hidden = true },
      lsp_file_methods = {
        autosave_changes = true,
      },
      watch_for_changes = true,
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
  },
}
