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
        ty = {
          cmd = function(dispatchers, config)
            return vim.lsp.rpc.start({ "ty", "server" }, dispatchers, {
              cwd = config.root_dir,
              env = config.cmd_env,
              detached = config.detached,
            })
          end,
        },
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
