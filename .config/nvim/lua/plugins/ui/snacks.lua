-- https://github.com/folke/snacks.nvim
--

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    scroll = {
      enabled = false,
    },
    ---
    dashboard = {
      enabled = true,
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
    indent = {
      enabled = true,
    },
    ---
    image = {
      enabled = true,
    },
    ---
    explorer = {
      trash = true,
    },
    --
    picker = {
      exclude = {
        ".git",
        ".DS_Store",
      },
      sources = {
        explorer = {
          ignored = true,
          hidden = true,

          win = {
            list = {
              keys = {
                ["<C-x>"] = { "edit_split", mode = { "i", "n" } },
              },
            },
          },
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
