return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- take LazyVim’s default prettier config and prepend your args
      opts.formatters.prettier = vim.tbl_extend("force", opts.formatters.prettier or {}, {
        prepend_args = { "--single-quote", "--semi" },
      })
    end,
  },
}
