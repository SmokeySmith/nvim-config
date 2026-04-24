return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				section_separators = "",
				component_separators = "",
				globalstatus = true,
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },

				lualine_c = {
					{
						"filename",
						path = 1,
					},
					{
						function()
							if vim.fn.exists("*FugitiveStatusline") == 1 then
								return vim.fn.FugitiveStatusline()
							end
							return ""
						end,
					},
				},

				lualine_x = {
					"diagnostics",
					"encoding",
					"filetype",
				},

				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
