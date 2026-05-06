return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "Agents.md",
		-- for example
		provider = "copilot",
		providers = {
			providers = {
				copilot = {
					model = "claude-sonnet-4",
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				},
				-- claude = {
				-- 	endpoint = "https://api.anthropic.com",
				-- 	model = "claude-sonnet-4-20250514",
				-- 	timeout = 30000, -- Timeout in milliseconds
				-- 	extra_request_body = {
				-- 		temperature = 0.75,
				-- 		max_tokens = 20480,
				-- 	},
				-- },
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
	},
}
