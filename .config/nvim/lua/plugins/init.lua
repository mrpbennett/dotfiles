local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use "nvim-lua/plenary.nvim"
	use "nvim-lualine/lualine.nvim"
    use "lukas-reineke/indent-blankline.nvim"
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},
	  
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'}, -- completion plugin
		  {'hrsh7th/cmp-buffer'}, -- buffer completions
		  {'hrsh7th/cmp-path'}, -- path completions
		  {'hrsh7th/cmp-cmdline'}, -- cmdline completions
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},
	  
		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
		}
	  }
	

	-- get some nicer UI around lsp issues
    use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

	-- null-ls
	use "jose-elias-alvarez/null-ls.nvim"

	-- telescope
	use "nvim-telescope/telescope.nvim"
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	-- treesitter
	use "nvim-treesitter/nvim-treesitter"

	-- nvim-tree
	use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"

	-- toggleterm
	use {"akinsho/toggleterm.nvim", tag = '*'}

	-- markdown preview
    use {'iamcco/markdown-preview.nvim', run = 'cd app & npm install', cmd = 'MarkdownPreview'}

	-- color scheme
	use "folke/tokyonight.nvim"

	-- git
	use 'lewis6991/gitsigns.nvim'

	-- numb
	use "nacro90/numb.nvim"

	-- spectre
	use 'windwp/nvim-spectre'

	-- which key
	use "folke/which-key.nvim"

	-- autopairs
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

	-- greeter
	use {
		'goolord/alpha-nvim',
		config = function ()
			require'alpha'.setup(require'alpha.themes.dashboard'.config)
		end
	}
   

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
end)

