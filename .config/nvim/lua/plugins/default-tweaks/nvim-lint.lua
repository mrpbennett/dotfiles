-- https://github.com/mfussenegger/nvim-lint
-- linter
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      sh = { "bash" },
      bash = { "bash" },
      --
      sql = { "sqruff" },
      --
      yaml = { "yamllint" },
    },
  },
  init = function()
    LazyVim.on_load("nvim-lint", function()
      local lint = require("lint")
      lint.linters.yamllint.cwd = function()
        return vim.fs.root(0, { ".yamllint", ".git" }) or vim.fn.getcwd()
      end

      -- Match conform's sqruff config/dialect so lint diagnostics agree with fix-on-save.
      lint.linters.sqruff.args = {
        "lint",
        "--format=json",
        "--config",
        vim.fn.expand("~/.config/sqruff/.sqruff"),
        "--dialect",
        function()
          return require("util.sqruff").dialect(vim.api.nvim_buf_get_name(0))
        end,
        "-",
      }
    end)
  end,
}
