return {
  {
    "kristijanhusak/vim-dadbod-ui",
    optional = true,
    init = function()
      vim.g.db_ui_execute_on_save = false
      vim.g.db_ui_use_nvim_notify = true
      vim.g.db_ui_table_helpers = vim.tbl_deep_extend("force", vim.g.db_ui_table_helpers or {}, {
        trino = {
          List    = "SELECT * FROM {optional_schema}{table} LIMIT 200",
          Columns = "SELECT column_name, data_type, is_nullable FROM information_schema.columns WHERE table_name = '{table}' AND table_schema = '{schema}'",
          Count   = "SELECT count(*) FROM {optional_schema}{table}",
          Describe = "DESCRIBE {optional_schema}{table}",
        },
      })
    end,
  },
}
