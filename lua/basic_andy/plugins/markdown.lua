-- In-buffer markdown rendering: headings, code blocks, tables, checkboxes.
-- Parsers (`markdown`, `markdown_inline`) are installed in treesitter.lua.
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    opts = {
      -- Render everywhere except while editing the line under the cursor.
      render_modes = { "n", "c", "t" },
      heading = { sign = false },
      code = { sign = false, width = "block", left_pad = 1, right_pad = 1 },
      checkbox = { enabled = true },
    },
    keys = {
      { "<leader>cm", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle [m]arkdown render" },
    },
  },
}
