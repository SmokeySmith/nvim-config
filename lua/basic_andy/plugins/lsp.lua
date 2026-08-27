-- LSP, using the 0.11+ `vim.lsp.config` / `vim.lsp.enable` API.
--
-- Neovim 0.11+ already ships these defaults on attach:
--   grn = rename, gra = code action, grr = references,
--   gri = implementation, grt = type definition, gO = document symbols,
--   K = hover, <C-s> (insert) = signature help.
-- Everything below is additive.
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} }, -- LSP progress in the corner
      -- Lua LSP that understands the Neovim runtime and your plugin sources.
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- Servers to install via Mason and enable. Keys are lspconfig names;
      -- values are config overrides merged over the lspconfig defaults.
      local servers = {
        bashls = {},
        cssls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {},
        ruff = {},
        rust_analyzer = {},
        ts_ls = {},
        yamlls = {},
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
      }

      -- mason-lspconfig takes *lspconfig* server names and maps them to Mason
      -- package names for us, so the `servers` keys above can be used directly.
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = true,
      })

      -- mason-tool-installer talks to the Mason registry directly, so these
      -- must be *Mason package* names (`stylua`, not `stylua_ls`). Only
      -- formatters/linters here — servers are handled above.
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettierd",
          "shfmt",
          "goimports",
        },
        run_on_start = true,
      })

      for name, config in pairs(servers) do
        if next(config) ~= nil then
          vim.lsp.config(name, config)
        end
        vim.lsp.enable(name)
      end

      -- Buffer-local keymaps and per-server features.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("basic_andy_lsp_attach", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          local function map(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("<leader>cr", vim.lsp.buf.rename, "[C]ode [r]ename")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ction", { "n", "x" })
          map("<leader>cs", vim.lsp.buf.signature_help, "[C]ode [s]ignature")

          -- Toggle inlay hints, if the server provides them.
          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            map("<leader>ch", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
            end, "Toggle inlay [h]ints")
          end

          -- Highlight other references to the symbol under the cursor.
          if client:supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("basic_andy_lsp_highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = bufnr,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = bufnr,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}
