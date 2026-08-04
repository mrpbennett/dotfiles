-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = {
        -- To fix auto-fixable lint errors.
        "ruff_fix",
        -- To run the Ruff formatter.
        "ruff_format",
        -- To organize the imports.
        "ruff_organize_imports",
      },
      sql = { "sqruff" },
      yaml = { "yamlfmt" }, -- Replace default with K8s-friendly formatter
    },
    formatters = {
      sqruff = {
        -- sqruff fix emits an extra trailing newline on stdout; strip trailing blank lines via sed.
        -- Dialect is inferred from the filename prefix (bq_/pg_/trino_/vert_) since sqruff
        -- doesn't merge a project-local .sqruff with this shared config.
        command = "sh",
        args = function(_, ctx)
          local name = vim.fn.fnamemodify(ctx.filename, ":t"):lower()
          local dialect = "trino"
          if name:match("^bq[_%.]") then
            dialect = "bigquery"
          elseif name:match("^pg[_%.]") or name:match("^postgres[_%.]") then
            dialect = "postgres"
          elseif name:match("^vert[_%.]") then
            dialect = "vertica"
          end
          return {
            "-c",
            "sqruff fix --config "
              .. vim.fn.expand("~/.config/sqruff/.sqruff")
              .. " --dialect "
              .. dialect
              .. " - | sed -e :a -e '/^$/{$d;N;ba' -e '}'",
          }
        end,
        stdin = true,
      },
      yamlfmt = {
        command = "yamlfmt",
        args = { "-in" },
        stdin = true,
      },
    },
  },
}
