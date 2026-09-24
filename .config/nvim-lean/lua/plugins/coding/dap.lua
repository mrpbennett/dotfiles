vim.pack.add {
  { src = "https://github.com/mfussenegger/nvim-dap" },
}

local dap = require("dap")
local map = vim.keymap.set

local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  local args_str = type(args) == "table" and table.concat(args, " ") or args

  config = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str))
    if config.type == "java" then
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "Breakpoint Condition" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "Run/Continue" })
map("n", "<leader>da", function() dap.continue({ before = get_args }) end, { desc = "Run with Args" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
map("n", "<leader>dg", dap.goto_, { desc = "Go to Line (No Execute)" })
map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
map("n", "<leader>dj", dap.down, { desc = "Down" })
map("n", "<leader>dk", dap.up, { desc = "Up" })
map("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
map("n", "<leader>do", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dO", dap.step_over, { desc = "Step Over" })
map("n", "<leader>dP", dap.pause, { desc = "Pause" })
map("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
map("n", "<leader>ds", dap.session, { desc = "Session" })
map("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
map("n", "<leader>dw", require("dap.ui.widgets").hover, { desc = "Widgets" })
