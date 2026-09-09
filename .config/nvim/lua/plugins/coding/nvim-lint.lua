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
      local yamllint = lint.linters.yamllint
      lint.linters.yamllint = function()
        local base = type(yamllint) == "function" and yamllint() or yamllint
        return vim.tbl_extend("force", base, {
          cwd = vim.fs.root(0, { ".yamllint", ".git" }) or vim.fngetcwd(),
        })
      end

      -- Match conform's sqruff config/dialect so lint diagnostics agree with fix-on-save.
      lint.linters.sqruff.args = {
        "lint",
        "--format=json",
        "--config",
        vim.fn.expand("~/.config/sqruff/.sqruff"),
        "--dialect",
        function()
          return require("utils.sqruff").dialect(vim.api.nvim_buf_get_name(0))
        end,
        "-",
      }
    end)
  end,
}
