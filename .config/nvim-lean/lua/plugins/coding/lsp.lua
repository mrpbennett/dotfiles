vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		-- lua
		"lua-language-server",

		-- go
		"gopls",
		"goimports",
		"gofumpt",
		"gomodifytags",
		"impl",

		-- python
		"ty",
		"ruff",

		-- sql
		"sqruff",

		-- yaml
		"yaml-language-server",
		"yamllint",
		"yamlfmt",
	},
})

-- Go
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
		},
	},
})

-- Python
vim.lsp.config("ty", {
	settings = {
		ty = {
			inlayHints = {
				variableTypes = true,
			},
		},
	},
	cmd = function(dispatchers, config)
		return vim.lsp.rpc.start({ "ty", "server" }, dispatchers, {
			cwd = config.root_dir,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,
})

vim.lsp.enable({
	-- lua
	"lua-language-server",

	-- go
	"gopls",
	"goimports",
	"gofumpt",
	"gomodifytags",
	"impl",

	-- python
	"ty",
	"ruff",

	-- sql
	"sqruff",

	-- yaml
	"yaml-language-server",
	"yamllint",
	"yamlfmt",
})
