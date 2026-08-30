return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    -- No `version` pin: blink.cmp v2 requires nvim 0.12+ and is tracked on the
    -- default branch. v2 split the Rust core out into blink.lib.
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
      "folke/lazydev.nvim",
    },
    -- v2 builds through the plugin rather than a raw cargo invocation.
    -- `gb` in the :Lazy UI rebuilds it.
    build = function()
      require("blink.cmp").build():pwait()
    end,
    ---@module 'blink.cmp'
    opts = {
      keymap = {
        -- <Tab> selects+accepts (or jumps snippet placeholders if one's active),
        -- <S-Tab> selects prev, arrow keys / <C-n>/<C-p> still cycle, <C-y> accepts.
        preset = "super-tab",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = {
          auto_brackets = { enabled = true },
          -- gopls resolves auto-import edits async via completionItem/resolve;
          -- the 100ms default is too short, so quick accepts drop the import.
          resolve_timeout_ms = 500,
        },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = false },
        list = { selection = { preselect = false, auto_insert = true } },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = {
          -- lazydev supplies the Neovim API completions; score it above LSP.
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
