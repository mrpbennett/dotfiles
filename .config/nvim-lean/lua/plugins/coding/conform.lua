vim.pack.add {
  { src = "https://github.com/stevearc/conform.nvim" },
}

require("conform").setup({

  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },

  formatters_by_ft = {
    python = {
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    },
    go = { "goimports", "gofumpt" },
    sql = { "sqruff" },
    yaml = { "yamlfmt" },
  },

  formatters = {
    --
    sqruff = {
      -- Dialect is inferred from the filename prefix.
      command = "sqruff",
      args = function(_, ctx)
        local sqruff = require("util.sqruff")
        local dialect = sqruff.dialect(ctx.filename)
        return {
          "fix", "--format", "none", "--config", sqruff.config(dialect),
          "--dialect", dialect, "-",
        }
      end,
      stdin = true,
    },
  },

  format_on_save = function(bufnr)
    if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
      return
    end
    return { timeout_ms = 3000, lsp_format = "fallback", quiet = true }
  end,
})
