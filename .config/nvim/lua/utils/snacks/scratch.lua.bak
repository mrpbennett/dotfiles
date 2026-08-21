-- lua/utils/snacks/scratch.lua
-- Custom scratch helpers for folke/snacks.nvim
--   M.new_scratch(filetypes) -> pick a filetype (or type a custom one), open a new scratch
--   M.select_scratch()       -> list existing scratches with a content preview; <C-x> deletes

local M = {}

-- shared column widths for the aligned columns in the selector
local column_widths = { 0, 0, 0, 0 }

local function reset_column_widths()
  column_widths[1], column_widths[2], column_widths[3], column_widths[4] = 0, 0, 0, 0
end

local function update_column_widths(item)
  column_widths[1] = math.max(column_widths[1], vim.api.nvim_strwidth(item.cwd))
  column_widths[2] = math.max(column_widths[2], vim.api.nvim_strwidth(item.icon))
  column_widths[3] = math.max(column_widths[3], vim.api.nvim_strwidth(item.name))
  column_widths[4] = math.max(column_widths[4], vim.api.nvim_strwidth(item.branch))
end

-- snacks.scratch.File has optional cwd / branch / icon, so guard every field
local function process_item(item)
  item.branch = item.branch and ("branch:%s"):format(item.branch) or ""
  item.cwd = item.cwd and vim.fn.fnamemodify(item.cwd, ":p:~") or ""
  item.icon = item.icon or Snacks.util.icon(item.ft, "filetype")
  item.name = item.name or ""
  update_column_widths(item)
end

local function process_items(items)
  for _, item in ipairs(items) do
    process_item(item)
  end
end

local function format_item_text(item)
  local parts = { item.cwd or "", item.icon or "", item.name or "", item.branch or "" }
  for i, part in ipairs(parts) do
    parts[i] = part .. string.rep(" ", column_widths[i] - vim.api.nvim_strwidth(part))
  end
  return table.concat(parts, " ")
end

function M.select_scratch()
  reset_column_widths()
  local items = Snacks.scratch.list()
  process_items(items)
  -- precompute display text once widths are known. Done here rather than via the
  -- picker `transform` option, whose signature is now a filter transform in latest snacks.
  for _, item in ipairs(items) do
    item.text = format_item_text(item)
  end

  Snacks.picker.pick({
    items = items,
    format = "text",
    preview = "file", -- preview the actual scratch file contents
    layout = {
      preview = true,
      preset = function()
        return vim.o.columns >= 120 and "default" or "vertical"
      end,
      layout = { title = " Select Scratch Buffer: " },
    },
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "delete", mode = { "i", "n" } },
        },
      },
    },
    actions = {
      delete = function(picker, item)
        if item and item.file then
          os.remove(item.file)
        end
        picker:close()
        M.select_scratch()
      end,
    },
    confirm = function(_, item)
      if item then
        Snacks.scratch.open({ icon = item.icon, file = item.file, name = item.name, ft = item.ft })
      end
    end,
  })
end

function M.new_scratch(filetypes)
  Snacks.picker.pick({
    items = filetypes,
    format = "text",
    layout = {
      preset = "vscode",
      preview = false,
      layout = { title = " Select a filetype: " },
    },
    confirm = function(picker, item)
      -- capture the typed text before closing so a custom (unlisted) filetype works
      local pattern = picker.input.filter.pattern
      picker:close()
      vim.schedule(function()
        local ft = (item and item.text) or pattern
        if ft and ft ~= "" then
          Snacks.scratch({ ft = ft, id = tostring(os.time()) })
        end
      end)
    end,
  })
end

return M
