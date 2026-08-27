return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        -- Native fzf sorter: much faster on big repos. Needs `make` + a C compiler.
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "[F]ind [f]iles" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "[F]ind by [g]rep" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "[F]ind current [w]ord" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[F]ind [b]uffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "[F]ind [h]elp" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "[F]ind [k]eymaps" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "[F]ind [d]iagnostics" },
      { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "[F]ind [r]esume last picker" },
      { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "[F]ind [o]ld files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "[F]ind document [s]ymbols" },
      { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "[F]ind workspace [S]ymbols" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in current buffer" },
      { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Switch buffer" },
      {
        "<leader>fn",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "[F]ind [n]eovim config files",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.9,
            height = 0.85,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-u>"] = false, -- clear the prompt instead of scrolling preview
            },
          },
          file_ignore_patterns = { "%.git/", "node_modules/", "target/", "dist/" },
        },
        pickers = {
          find_files = { hidden = true },
          buffers = { sort_mru = true, ignore_current_buffer = true },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
  },
}
