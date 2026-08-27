-- nvim-treesitter `main` branch: parsers are installed imperatively and
-- highlighting is started per-buffer via `vim.treesitter.start`.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({})

      ts.install({
        "bash",
        "c",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json", -- also handles jsonc
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })

      local available = ts.get_available()

      --- Start highlighting + treesitter indent for `buf`, if the parser loads.
      local function attach(buf, lang)
        if not vim.treesitter.language.add(lang) then
          return
        end
        vim.treesitter.start(buf, lang)
        -- Fall back to the built-in indentexpr when there's no indents query.
        if vim.treesitter.query.get(lang, "indents") then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("basic_andy_treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          if vim.tbl_contains(ts.get_installed("parsers"), lang) then
            attach(args.buf, lang)
          elseif vim.tbl_contains(available, lang) then
            -- Auto-install on first encounter, then attach.
            ts.install(lang):await(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                attach(args.buf, lang)
              end
            end)
          else
            -- Parser may exist outside nvim-treesitter (e.g. shipped with nvim).
            attach(args.buf, lang)
          end
        end,
      })
    end,
  },

  -- Structural text objects: `af`/`if` for functions, `ac`/`ic` for classes, etc.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      local textobjects = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      }

      for key, query in pairs(textobjects) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end

      local moves = {
        ["]f"] = { "@function.outer", "next_start", "Next function start" },
        ["]F"] = { "@function.outer", "next_end", "Next function end" },
        ["[f"] = { "@function.outer", "previous_start", "Previous function start" },
        ["[F"] = { "@function.outer", "previous_end", "Previous function end" },
        ["]c"] = { "@class.outer", "next_start", "Next class start" },
        ["[c"] = { "@class.outer", "previous_start", "Previous class start" },
      }

      for key, spec in pairs(moves) do
        local query, direction, desc = spec[1], spec[2], spec[3]
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move["goto_" .. direction](query, "textobjects")
        end, { desc = desc })
      end
    end,
  },
}
