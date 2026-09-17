-- https://github.com/mfussenegger/nvim-lint
-- linter
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      sh = { "bash" },
      bash = { "bash" },
      --
      python = { "ruff" },
      --
      sql = { "sqruff" },
      --
      yaml = { "yamllint" },
    },
  },
  init = function()
    LazyVim.on_load("nvim-lint", function()
      local lint = require("lint")
      -- lint.linters entries can be a function returning a fresh linter table; this is the
      -- only way to get a per-invocation `cwd`, since nvim-lint reads linter.cwd as a plain
      -- string (unlike `args`, it is never function-evaluated).
      local yamllint = lint.linters.yamllint
      lint.linters.yamllint = function()
        local base = type(yamllint) == "function" and yamllint() or yamllint
        return vim.tbl_extend("force", base, {
          cwd = vim.fs.root(0, { ".yamllint", ".git" }) or vim.fn.getcwd(),
        })
      end

      -- Match conform's sqruff config/dialect so lint diagnostics agree with fix-on-save.
      lint.linters.sqruff.args = {
        "lint",
        "--format=json",
        "--config",
        function()
          local sqruff = require("util.sqruff")
          return sqruff.config(sqruff.dialect(vim.api.nvim_buf_get_name(0)))
        end,
        "--dialect",
        function()
          return require("util.sqruff").dialect(vim.api.nvim_buf_get_name(0))
        end,
        "-",
      }
    end)
  end,
}
