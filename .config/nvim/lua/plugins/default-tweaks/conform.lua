-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqruff" },
      yaml = { "yamlfmt" }, -- Replace default with K8s-friendly formatter
    },
    formatters = {
      sqruff = {
        -- sqruff fix emits an extra trailing newline on stdout; strip trailing blank lines via sed.
        command = "sh",
        args = {
          "-c",
          "sqruff fix --config " .. vim.fn.expand("~/.config/sqruff/.sqruff") .. " - | sed -e :a -e '/^$/{$d;N;ba' -e '}'",
        },
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
