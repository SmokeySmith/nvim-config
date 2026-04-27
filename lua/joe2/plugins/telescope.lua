return {
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local data = assert(vim.fn.stdpath("data")) --[[@as string]]
			require("telescope").setup({
				defaults = {},
				extensions = {
					wrap_results = true,

					fzf = {},
					-- history = {
					--   path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
					--   limit = 100,
					-- },
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "smart_history")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader><leader>", builtin.find_files)
			-- vim.keymap.set("n", "<space>ft", function()
			--   return builtin.git_files { cwd = vim.fn.expand "%:h" }
			-- end)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader>fk", builtin.keymaps)
			vim.keymap.set("n", "<leader>fb", builtin.buffers)
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
			vim.keymap.set("n", "<leader>fc", builtin.commands)

			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
			vim.keymap.set("n", "<leader>st", builtin.builtin)
			vim.keymap.set("n", "<leader>sw", builtin.grep_string)
			vim.keymap.set("n", "<leader>sg", builtin.live_grep)
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics)

			-- vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches" })
			-- vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "Git Log" })
			-- vim.keymap.set("n", "<leader>gL", builtin.git_bcommits_range, { desc = "Git Log Line" })
			-- vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
			-- vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Git Stash" })
			-- vim.keymap.set("n", "<leader>gd", builtin.git_commits, { desc = "Git Diff (pick commit)" })
			-- vim.keymap.set("n", "<leader>gf", builtin.git_bcommits, { desc = "Git Log File" })

			vim.keymap.set("n", "<leader>fe", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end)

			vim.keymap.set("n", "<leader>fp", function()
				builtin.find_files({ cwd = "~/plugins/" })
			end)

			vim.keymap.set("n", "<leader>eo", function()
				builtin.find_files({ cwd = "~/.config/nvim-backup/" })
			end)
		end,
	},
}
