return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
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
      },
    },
  },
}
