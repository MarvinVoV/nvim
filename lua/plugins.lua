-- Plugin manager (Packer.nvim)
-- Only required if you have packer configured as `opt`

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("tpope/vim-fugitive")
	use("bluz71/vim-nightfly-guicolors")
	use("nvim-lua/plenary.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("neovim/nvim-lspconfig")
	use({ "neoclide/coc.nvim", branch = "release" })

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/cmp-cmdline")

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- nvim-tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("nvim-tree").setup({
				-- configuration
			})
		end,
	})

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- indent-blankline
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end,
	})

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	-- Which-key
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				triggers_blacklist = {
					i = { "c", "'", "<c-s>", "j", "k" },
					v = { "j", "k" },
				},
			})
		end,
	})

	-- neoformat
	use({
		"sbdchd/neoformat",
		config = function()
			vim.g.neoformat_basic_format_align = 1
			vim.g.neoformat_basic_format_retab = 1
			vim.g.neoformat_basic_format_trim = 1

			vim.g.neoformat_enabled_python = "autopep8"

			vim.g.neoformat_java_google = {
				exe = "google-java-format",
				args = {},
				replace = 1,
				stdin = 1,
				stdout = 0,
				sync = 1,
			}

			vim.g.neoformat_lua_stylua = {
				exe = "stylua",
				args = {},
				replace = 1,
				stdin = 1,
				stdout = 0,
				sync = 1,
			}
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
