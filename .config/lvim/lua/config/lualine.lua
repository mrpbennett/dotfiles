-- Lualine has sections as shown below.
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

-- no need to set style = "lvim"
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
        statusline = {},
        winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
    }
}

-- Vim mode
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_b = {
    components.branch,
    components.diff,
    components.diagnostics,
}
lvim.builtin.lualine.sections.lualine_c = {
    components.filename
}
lvim.builtin.lualine.sections.lualine_x = {
    components.encoding,
    components.fileformat,
    components.filetype
}
lvim.builtin.lualine.sections.lualine_y = {
    components.progress,
}

lvim.builtin.lualine.sections.lualine_z = {
    components.location,
}

lvim.builtin.lualine.inactive_sections.lualine_c = {
    components.filename,
}

lvim.builtin.lualine.inactive_sections.lualine_x = {
    components.location,
}
