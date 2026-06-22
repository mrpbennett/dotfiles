-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("i", "jk", "<Esc>", { noremap = false })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Pop a terminal window with K9s
if vim.fn.executable("k9s") == 1 then
  vim.keymap.set("n", "<leader>tk", function()
    Snacks.terminal("k9s")
  end, { desc = "K9s (Kubernetes)" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>tk", icon = { icon = "󱃾", color = "blue" } },
  })
end

-- Pop a terminal window with Hunk
if vim.fn.executable("hunk") == 1 then
  vim.keymap.set("n", "<leader>thd", function()
    Snacks.terminal("hunk diff")
  end, { desc = "Hunk Diff" })

  vim.keymap.set("n", "<leader>ths", function()
    Snacks.terminal("hunk show")
  end, { desc = "Hunk Show" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>th", group = "Hunk", icon = { icon = "", color = "green" } },
  })
end

-- Pop a terminal window with LazyDocker
if vim.fn.executable("lazydocker") == 1 then
  vim.keymap.set("n", "<leader>td", function()
    Snacks.terminal("lazydocker")
  end, { desc = "LazyDocker" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>td", icon = { icon = "󱃾", color = "blue" } },
  })
end

-- Pop a terminal window with Bucky
if vim.fn.executable("bucky") == 1 then
  vim.keymap.set("n", "<leader>tb", function()
    Snacks.terminal("bucky")
  end, { desc = "Bucky" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>tb", icon = { icon = "󱐕", color = "orange" } },
  })
end

-- Pop GH-Dash window
if vim.fn.executable("gh-dash") == 1 then
  vim.keymap.set("n", "<leader>tg", function()
    Snacks.terminal("gh-dash")
  end, { desc = "GH-Dash" })

  -- Add icon via which-key
  require("which-key").add({
    { "<leader>tg", icon = { icon = "", color = "orange" } },
  })
end
