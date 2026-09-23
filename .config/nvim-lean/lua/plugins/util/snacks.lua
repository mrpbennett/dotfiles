vim.pack.add({
    "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
    bigfile = { enabled = true },
    dashboard = {
        enabled = true,
        preset = {
            header = [[
 __   __     __   __   __     __    __
/\ "-.\ \   /\ \ / /  /\ \   /\ "-./  \
\ \ \-.  \  \ \ \'/   \ \ \  \ \ \-./\ \
 \ \_\\"\_\  \ \__|    \ \_\  \ \_\ \ \_\
  \/_/ \/_/   \/_/      \/_/   \/_/  \/_/
]],
        },
        sections = {
            { section = "header" },
            { section = "keys",  gap = 1, padding = 1 },
        },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
        enabled = true,
        timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
})

local function map(mode, lhs, rhs, desc, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts or {}))
end

-- Top Pickers & Explorer
map("n", "<leader><space>", function() Snacks.picker.smart() end, "Smart Find Files")
map("n", "<leader>,", function() Snacks.picker.buffers() end, "Buffers")
map("n", "<leader>/", function() Snacks.picker.grep() end, "Grep")
map("n", "<leader>:", function() Snacks.picker.command_history() end, "Command History")
map("n", "<leader>n", function() Snacks.picker.notifications() end, "Notification History")
map("n", "<leader>e", function() Snacks.explorer() end, "File Explorer")

-- find
map("n", "<leader>fb", function() Snacks.picker.buffers() end, "Buffers")
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File")
map("n", "<leader>ff", function() Snacks.picker.files() end, "Find Files")
map("n", "<leader>fg", function() Snacks.picker.git_files() end, "Find Git Files")
map("n", "<leader>fp", function() Snacks.picker.projects() end, "Projects")
map("n", "<leader>fr", function() Snacks.picker.recent() end, "Recent")

-- git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, "Git Branches")
map("n", "<leader>gl", function() Snacks.picker.git_log() end, "Git Log")
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, "Git Log Line")
map("n", "<leader>gs", function() Snacks.picker.git_status() end, "Git Status")
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, "Git Stash")
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, "Git Diff (Hunks)")
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, "Git Log File")

-- gh
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, "GitHub Issues (open)")
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, "GitHub Issues (all)")
map("n", "<leader>gp", function() Snacks.picker.gh_pr() end, "GitHub Pull Requests (open)")
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, "GitHub Pull Requests (all)")

-- Grep
map("n", "<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, "Grep Open Buffers")
map("n", "<leader>sg", function() Snacks.picker.grep() end, "Grep")
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, "Visual selection or word")

-- search
map("n", '<leader>s"', function() Snacks.picker.registers() end, "Registers")
map("n", "<leader>s/", function() Snacks.picker.search_history() end, "Search History")
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, "Autocmds")
map("n", "<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
map("n", "<leader>sc", function() Snacks.picker.command_history() end, "Command History")
map("n", "<leader>sC", function() Snacks.picker.commands() end, "Commands")
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, "Diagnostics")
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
map("n", "<leader>sh", function() Snacks.picker.help() end, "Help Pages")
map("n", "<leader>sH", function() Snacks.picker.highlights() end, "Highlights")
map("n", "<leader>si", function() Snacks.picker.icons() end, "Icons")
map("n", "<leader>sj", function() Snacks.picker.jumps() end, "Jumps")
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, "Keymaps")
map("n", "<leader>sl", function() Snacks.picker.loclist() end, "Location List")
map("n", "<leader>sm", function() Snacks.picker.marks() end, "Marks")
map("n", "<leader>sM", function() Snacks.picker.man() end, "Man Pages")
map("n", "<leader>sp", function() Snacks.picker.lazy() end, "Search for Plugin Spec")
map("n", "<leader>sq", function() Snacks.picker.qflist() end, "Quickfix List")
map("n", "<leader>sR", function() Snacks.picker.resume() end, "Resume")
map("n", "<leader>su", function() Snacks.picker.undo() end, "Undo History")
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, "Colorschemes")

-- LSP
map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
map("n", "gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
map("n", "gr", function() Snacks.picker.lsp_references() end, "References", { nowait = true })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto T[y]pe Definition")
map("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, "C[a]lls Incoming")
map("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, "C[a]lls Outgoing")
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")

-- Other
map("n", "<leader>z", function() Snacks.zen() end, "Toggle Zen Mode")
map("n", "<leader>Z", function() Snacks.zen.zoom() end, "Toggle Zoom")
map("n", "<leader>.", function() Snacks.scratch() end, "Toggle Scratch Buffer")
map("n", "<leader>S", function() Snacks.scratch.select() end, "Select Scratch Buffer")
map("n", "<leader>n", function() Snacks.notifier.show_history() end, "Notification History")
map("n", "<leader>bd", function() Snacks.bufdelete() end, "Delete Buffer")
map("n", "<leader>cR", function() Snacks.rename.rename_file() end, "Rename File")
map({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, "Git Browse")
map("n", "<leader>gg", function() Snacks.lazygit() end, "Lazygit")
map("n", "<leader>un", function() Snacks.notifier.hide() end, "Dismiss All Notifications")
map("n", "<c-/>", function() Snacks.terminal() end, "Toggle Terminal")
map("n", "<c-_>", function() Snacks.terminal() end, "which_key_ignore")
map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")
map("n", "<leader>N", function()
    Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
        },
    })
end, "Neovim News")

-- Debug globals
_G.dd = function(...)
    Snacks.debug.inspect(...)
end
_G.bt = function()
    Snacks.debug.backtrace()
end

-- Override print to use snacks for `:=` command
if vim.fn.has("nvim-0.11") == 1 then
    vim._print = function(_, ...)
        dd(...)
    end
else
    vim.print = _G.dd
end

-- Toggle mappings
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
    "<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")
