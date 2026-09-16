-- Shared sqruff dialect detection by filename prefix (bq_/pg_/trino_/tsql_/vert_).
-- Used by both conform.lua (fix) and nvim-lint.lua (lint) so the convention
-- can't drift between formatting and linting.
local M = {}

function M.dialect(filename)
  local name = vim.fn.fnamemodify(filename, ":t"):lower()
  if name:match("^bq[_%.]") then
    return "bigquery"
  elseif name:match("^pg[_%.]") or name:match("^postgres[_%.]") then
    return "postgres"
  elseif name:match("^tsql[_%.]") then
    return "tsql"
  elseif name:match("^vert[_%.]") then
    return "vertica"
  end
  return "trino"
end

function M.config(dialect)
  local filename = dialect == "tsql" and ".sqruff-tsql" or ".sqruff"
  return vim.fn.expand("~/.config/sqruff/" .. filename)
end

return M
