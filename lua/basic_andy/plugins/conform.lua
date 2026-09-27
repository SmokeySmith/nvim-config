return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "[C]ode [f]ormat buffer",
      },
      {
        "<leader>cF",
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end,
        desc = "Toggle [F]ormat on save",
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },
        cuda = { "clang-format" },
        go = { "goimports", "gofmt" },
        python = { "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        markdown = { "prettierd" },
        -- Fall back to any LSP formatter for filetypes not listed above.
        ["_"] = { lsp_format = "fallback" },
      },
      formatters = {
        -- clang-format defaults to LLVM style with an 80-column limit. A
        -- project's own .clang-format still wins; this only widens the style
        -- used when there isn't one. (--fallback-style only accepts named
        -- styles, so the inline config has to go through --style instead.)
        ["clang-format"] = {
          prepend_args = function(_, ctx)
            local found = vim.fs.find({ ".clang-format", "_clang-format" }, { path = ctx.dirname, upward = true })
            if #found > 0 then
              return {}
            end
            return { "--style={BasedOnStyle: LLVM, ColumnLimit: 100, IndentWidth: 4, TabWidth: 4, UseTab: Never}" }
          end,
        },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
    },
  },
}
