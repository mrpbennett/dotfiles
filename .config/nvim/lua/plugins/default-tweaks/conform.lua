-- https://github.com/stevearc/conform.nvim
-- formatter
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "google-java-format", "dockerfmt" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        --
        sh = { "shfmt" },
        bash = { "shfmt" },
        --
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports",
        },
        --
        sql = { "sqruff" },
        --
        yaml = { "yamlfmt" }, -- Replace default with K8s-friendly formatter
        --
        java = { "google-java-format" },
        --
        dockerfile = { "dockerfmt" },
        --
      },
      formatters = {
        --
        sqruff = {
          -- sqruff fix emits an extra trailing newline on stdout; strip trailing blank lines via sed.
          -- Dialect is inferred from the filename prefix (bq_/pg_/trino_/vert_) since sqruff
          -- doesn't merge a project-local .sqruff with this shared config.
          command = "sh",
          args = function(_, ctx)
            local dialect = require("util.sqruff").dialect(ctx.filename)
            return {
              "-c",
              "sqruff fix --format none --config "
                .. vim.fn.expand("~/.config/sqruff/.sqruff")
                .. " --dialect "
                .. dialect
                .. " - | sed -e :a -e '/^$/{$d;N;ba' -e '}'",
            }
          end,
          stdin = true,
        },
        --
        yamlfmt = {
          command = "yamlfmt",
          args = { "-in" },
          stdin = true,
        },
      },
    },
  },
}
