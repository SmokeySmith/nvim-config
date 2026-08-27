return {
	{
		"github/copilot.vim",
		config = function()
			-- require("copilot").setup()
			vim.g.copilot_filetypes = {
				["*"] = true,
			}
			vim.g.copilot_model = "gpt-5.4"
		end,
	},
}
