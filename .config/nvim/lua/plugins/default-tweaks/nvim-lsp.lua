-- https://github.com/neovim/nvim-lspconfig
-- lsp config
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        --
        bashls = {},
        --
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = {
                  "*/k8s/**/*.yaml",
                  "*/kubernetes/**/*.yaml",
                  "*/manifests/**/*.yaml",
                },
              },
            },
          },
        },
        --
      },
    },
  },
}
