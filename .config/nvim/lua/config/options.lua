-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enabling the mouse
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.inccommand = "split" -- better search window

-- make zsh default shell
vim.opt.shell = "/bin/zsh"

-- Stop auto comments
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- python lazyvim
-- this set by lang.python -> vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_python_lsp = "ty"

-- Disable the option to require a Prettier config file
vim.g.lazyvim_prettier_needs_config = false

-- Auto-detect macOS dark/light mode
local function get_macos_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result:match("Dark") then
      return "dark"
    end
  end
  return "light"
end

vim.o.background = get_macos_appearance()
