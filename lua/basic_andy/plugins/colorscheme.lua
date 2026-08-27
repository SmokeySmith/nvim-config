return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- load before everything else so highlights are correct
    opts = {
      style = "night",
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- A couple of alternatives, installed but not active. Swap the colorscheme
  -- call above (or just `:colorscheme catppuccin`) to try them.
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
}
