vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-lint" },
})

local lint = require("lint")

lint.linters.sqruff.args = {
  "lint", "--format=json",
  "--config", function()
  local sqruff = require("util.sqruff")
  return sqruff.config(sqruff.dialect(vim.api.nvim_buf_get_name(0)))
end,
  "--dialect", function()
  return require("util.sqruff").dialect(vim.api.nvim_buf_get_name(0))
end,
  "-",
}

lint.linters_by_ft = {
  python = { "ruff" },
  sql = { "sqruff" },
  yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("user_lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
