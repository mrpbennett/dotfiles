-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- Stop auto comments
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Python
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"

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
