return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000, -- load before everything else so highlights are correct
	-- 	opts = {
	-- 		style = "night",
	-- 		styles = {
	-- 			comments = { italic = true },
	-- 			keywords = { italic = false },
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("tokyonight").setup(opts)
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
	--
	-- -- A couple of alternatives, installed but not active. Swap the colorscheme
	-- -- call above (or just `:colorscheme catppuccin`) to try them.
	-- { "catppuccin/nvim", name = "catppuccin", lazy = true },
	-- { "rebelot/kanagawa.nvim", lazy = true },
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			variant = "light",
		},
		config = function(_, opts)
			require("cyberdream").setup(opts)
			vim.cmd.colorscheme("cyberdream")
		end,
	},
	-- lua/plugins/rose-pine.lua
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },
	---- lazy.nvim
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				style = "modus_operandi",
				variant = "tinted", -- try "tinted" if pure white feels glary
				styles = {
					comments = { italic = false },
					keywords = { italic = false, bold = true },
					functions = {},
					variables = {},
				},
			})
			vim.cmd("colorscheme modus_operandi")
		end,
	},
}
