vim.pack.add({
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
})

require("tiny-inline-diagnostic").setup({
	preset = "powerline",
	add_messages = {
		display_count = true,
	},
	multilines = {
		enabled = true,
	},
})
