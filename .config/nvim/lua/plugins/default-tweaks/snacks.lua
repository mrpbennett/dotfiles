-- https://github.com/folke/snacks.nvim
--

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  keys = {
    {
      "<leader>.",
      function()
        require("utils.snacks.scratch").new_scratch({
          { text = "go" },
          { text = "html" },
          { text = "javascript" },
          { text = "python" },
          { text = "sql" },
          { text = "yaml" },
        })
      end,
      desc = "New Scratch (pick filetype)",
    },
    {
      "<leader>S",
      function()
        require("utils.snacks.scratch").select_scratch()
      end,
      desc = "Select Scratch Buffer",
    },
  },
  opts = {
    ---
    dashboard = {
      enabled = true,
      example = "compact_files",
      preset = {
        header = [[
 __         ______     ______     __  __     __   __   __     __    __    
/\ \       /\  __ \   /\___  \   /\ \_\ \   /\ \ / /  /\ \   /\ "-./  \   
\ \ \____  \ \  __ \  \/_/  /__  \ \____ \  \ \ \'/   \ \ \  \ \ \-./\ \  
 \ \_____\  \ \_\ \_\   /\_____\  \/\_____\  \ \__|    \ \_\  \ \_\ \ \_\ 
  \/_____/   \/_/\/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/ 
        ]],
      },
    },
    ---
    dim = {
      enabled = true,
    },
    ---
    image = {
      enabled = true,
    },
    ---
    picker = {
      exclude = {
        ".git",
        ".venv",
        ".DS_Store",
      },
      sources = {
        explorer = {
          ignored = true,
          hidden = true,
        },
        files = {
          ignored = true,
          hidden = true,
        },
      },
    },
    ---
  },
  ---
}
