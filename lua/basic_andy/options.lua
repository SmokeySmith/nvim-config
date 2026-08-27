-- Leader keys. Must be set before lazy.nvim loads any plugin spec.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to false if your terminal font lacks glyphs.
vim.g.have_nerd_font = true

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.colorcolumn = "100"
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.laststatus = 3 -- single global statusline
opt.showmode = false -- the statusline already shows it
opt.winborder = "rounded" -- 0.11+: default border for floats

-- Whitespace / listchars
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Indentation: 2 spaces by default, per-filetype overrides live in autocmds.lua
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split" -- live preview for :substitute

-- Files & undo
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.autoread = true
opt.confirm = true -- prompt instead of failing on unsaved changes

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Folding via treesitter, but start with everything open.
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevel = 99
opt.foldenable = true

-- Misc
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.timeoutlen = 300
opt.virtualedit = "block"

-- Diagnostics: virtual text off, virtual lines on the current line only, so
-- long messages don't shove code around.
vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  virtual_lines = { current_line = true },
  float = { border = "rounded", source = "if_many" },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or true,
})
