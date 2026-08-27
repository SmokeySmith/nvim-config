return {
  -- mini.nvim modules, each cheap and independent.
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- gza"  gzd'  gzr(  -> add / delete / replace surrounding
      require("mini.surround").setup()

      -- Extra text objects: va) vi] etc. made smarter, plus `f`, `a`, `q`.
      require("mini.ai").setup({ n_lines = 500 })

      -- Auto-close brackets and quotes.
      require("mini.pairs").setup()

      -- Show and operate on indent scope.
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })

      -- No mini.comment: Neovim 0.10+ has native `gc`/`gcc` commenting.
    end,
  },

  -- Discoverable keymaps: press <leader> and wait.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>x", group = "diagnostics/quickfix" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer local keymaps",
      },
    },
  },

  -- File explorer that edits the filesystem as a normal buffer.
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font } },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      keymaps = {
        ["<C-h>"] = false, -- keep window navigation
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
      },
    },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
      { "<leader>-", "<cmd>Oil --float<CR>", desc = "Open parent directory (float)" },
    },
  },

  -- Diagnostics / quickfix list with a decent UI.
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
    },
  },

  -- TODO/FIXME/HACK highlighting, plus a picker for them.
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "[F]ind [t]odos" },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
    },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font } },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics", "filetype" },
      },
    },
  },

  -- Session-free quick navigation between a handful of files.
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local keys = {
        {
          "<leader>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon [a]dd file",
        },
        {
          "<C-e>",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon menu",
        },
      }
      for i = 1, 4 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon file " .. i,
        })
      end
      return keys
    end,
    opts = {},
  },
}
