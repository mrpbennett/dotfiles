require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "css",
        "dockerfile",
        "dot",
        "gitignore",
        "go",
        "html",
        "java",
        "javascript",
        "json",
        "markdown",
        "python",
        "sql",
        "toml",
        "yaml"
    }, -- one of "all" or a list of languages
	ignore_install = { "php" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "php" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { } },
  }