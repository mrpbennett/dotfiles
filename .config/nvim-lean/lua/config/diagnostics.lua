vim.fn.sign_define("DapBreakpoint", {
  text = "●", -- a large dot; change as desired
  texthl = "DapBreakpointSign", -- the highlight group you just defined
  linehl = "", -- no full-line highlight
  numhl = "", -- no number-column highlight
})

local sev = vim.diagnostic.severity

vim.diagnostic.config({
  -- keep underline & severity_sort on for quick scanning
  underline = true,
  severity_sort = true,
  update_in_insert = false, -- less flicker

  float = {
    border = "rounded",
    source = true,
  },

  -- Inline diagnostics are displayed by tiny-inline-diagnostic.
  signs = {
    text = {
      [sev.ERROR] = " ",
      [sev.WARN] = " ",
      [sev.INFO] = " ",
      [sev.HINT] = "󰌵 ",
    },
    linehl = {
      [sev.ERROR] = "DiagnosticErrorLine",
      [sev.WARN] = "DiagnosticWarnLine",
      [sev.INFO] = "DiagnosticInfoLine",
      [sev.HINT] = "DiagnosticHintLine",
    },
  },

  virtual_text = false,

})
