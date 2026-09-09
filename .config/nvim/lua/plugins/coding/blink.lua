-- https://github.com/saghen/blink.cmp
return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config

    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "orbit" },
        providers = {
          orbit = { name = "orbit", module = "orbit.blink" },
        },
      },
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
      },
    },
  },
}
