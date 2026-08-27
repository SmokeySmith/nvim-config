-- basic_andy: a standard, modern Neovim config (0.11+/0.12) built on lazy.nvim.
--
-- Load order matters: options (incl. mapleader) must come before lazy, since
-- plugin `keys = {}` specs are resolved at setup time.
require("basic_andy.options")
require("basic_andy.lazy")
require("basic_andy.keymaps")
require("basic_andy.autocmds")
