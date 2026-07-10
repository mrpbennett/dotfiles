-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- ============================================================================
-- Normal Mode
-- ============================================================================

-- ============================================================================
-- Insert Mode
-- ============================================================================

-- Exit insert mode with jk
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- ============================================================================
-- Visual Mode
-- ============================================================================

-- Copy to system clipboard with Cmd+C (without affecting yank register)
map("v", "<D-c>", function()
  local saved_reg = vim.fn.getreg('"')
  local saved_regtype = vim.fn.getregtype('"')
  vim.cmd('silent normal! "+ygv')
  vim.fn.setreg('"', saved_reg, saved_regtype)
end, { desc = "Copy to system clipboard" })

-- ============================================================================
-- Terminal Mode
-- ============================================================================

-- Exit terminal mode with double Escape
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- TUI Tooling
-- ============================================================================

-- Pop a terminal window with K9s
if vim.fn.executable("k9s") == 1 then
  map("n", "<leader>tk", function()
    Snacks.terminal("k9s")
  end, { desc = "K9s (Kubernetes)" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>tk", icon = { icon = "󱃾", color = "blue" } },
  })
end

-- Pop a terminal window with Hunk
if vim.fn.executable("hunk") == 1 then
  map("n", "<leader>thd", function()
    Snacks.terminal("hunk diff")
  end, { desc = "Hunk Diff" })

  map("n", "<leader>ths", function()
    Snacks.terminal("hunk show")
  end, { desc = "Hunk Show" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>th", group = "Hunk", icon = { icon = "", color = "green" } },
  })
end

-- Pop a terminal window with LazyDocker
if vim.fn.executable("lazydocker") == 1 then
  map("n", "<leader>td", function()
    Snacks.terminal("lazydocker")
  end, { desc = "LazyDocker" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>td", icon = { icon = "󱃾", color = "blue" } },
  })
end

-- Pop a terminal window with Bucky
if vim.fn.executable("bucky") == 1 then
  map("n", "<leader>tb", function()
    Snacks.terminal("bucky")
  end, { desc = "Bucky" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>tb", icon = { icon = "󱐕", color = "orange" } },
  })
end

-- Pop GH-Dash window
if vim.fn.executable("gh-dash") == 1 then
  map("n", "<leader>tg", function()
    Snacks.terminal("gh-dash")
  end, { desc = "GH-Dash" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>tg", icon = { icon = "", color = "orange" } },
  })
end
