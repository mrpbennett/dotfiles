-- https://github.com/folke/flash.nvim
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = false,
      },
      char = {
        jump_labels = true,
      },
    },
  },
  keys = {
    { "S", mode = { "n", "x", "o" }, false }, -- disables the S binding
  },
}
