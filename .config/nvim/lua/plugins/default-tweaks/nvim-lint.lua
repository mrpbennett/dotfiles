-- https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      yaml = { "yamllint" },
    },
  },
  init = function()
    LazyVim.on_load("nvim-lint", function()
      local lint = require("lint")
      lint.linters.yamllint.cwd = function()
        return vim.fs.root(0, { ".yamllint", ".git" }) or vim.fn.getcwd()
      end
    end)
  end,
}
