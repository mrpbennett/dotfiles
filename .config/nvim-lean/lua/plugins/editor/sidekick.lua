vim.pack.add({
    "https://github.com/folke/sidekick.nvim"
})


local map = vim.keymap.set

map("n", "<tab>", function()
    -- if there is a next edit, jump to it, otherwise apply it if any
    if not require("sidekick").nes_jump_or_apply() then
        return "<Tab>" -- fallback to normal tab
    end
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })

map({ "n", "t", "i", "x" }, "<c-.>", function()
    require("sidekick.cli").focus()
end, { desc = "Sidekick Focus" })

map("n", "<leader>aa", function()
    require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle CLI" })

map("n", "<leader>as", function()
    require("sidekick.cli").select()
    -- Or to select only installed tools:
    -- require("sidekick.cli").select({ filter = { installed = true } })
end, { desc = "Select CLI" })

map("n", "<leader>ad", function()
    require("sidekick.cli").close()
end, { desc = "Detach a CLI Session" })

map({ "x", "n" }, "<leader>at", function()
    require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Send This" })

map("n", "<leader>af", function()
    require("sidekick.cli").send({ msg = "{file}" })
end, { desc = "Send File" })

map("x", "<leader>av", function()
    require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Send Visual Selection" })

map({ "n", "x" }, "<leader>ap", function()
    require("sidekick.cli").prompt()
end, { desc = "Sidekick Select Prompt" })

-- Example of a keybinding to open Claude directly
map("n", "<leader>ac", function()
    require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "Sidekick Toggle Claude" })
