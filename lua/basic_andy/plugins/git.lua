return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- Navigate hunks; fall back to normal ]c/[c in diff mode.
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous hunk")

        map("n", "<leader>gs", gs.stage_hunk, "[S]tage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "[R]eset hunk")
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "[S]tage selection")
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "[R]eset selection")
        map("n", "<leader>gS", gs.stage_buffer, "[S]tage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "[R]eset buffer")
        map("n", "<leader>gp", gs.preview_hunk, "[P]review hunk")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "[B]lame line")
        map("n", "<leader>gd", gs.diffthis, "[D]iff against index")
        map("n", "<leader>gD", function()
          gs.diffthis("@")
        end, "[D]iff against HEAD")
        map("n", "<leader>gtb", gs.toggle_current_line_blame, "[T]oggle inline [b]lame")
        map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
      end,
    },
  },

  -- :Git, :Gdiffsplit, :Gblame, etc. Still the best interactive git UI in vim.
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gedit", "GBrowse" },
    keys = {
      { "<leader>gg", "<cmd>Git<CR>", desc = "[G]it status" },
      { "<leader>gl", "<cmd>Git log --oneline --graph --decorate<CR>", desc = "[G]it [l]og" },
    },
  },
}
