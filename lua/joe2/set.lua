vim.opt.nu = true
vim.opt.termguicolors = true
vim.opt.relativenumber = false

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.selection = "inclusive"
vim.opt.modifiable = true
vim.opt.encoding = "utf-8"

vim.g.have_nerd_font = true
vim.opt.mouse = 'a'

-- if windows clipboard breaks again
-- vim.g.clipboard = {
--   name = 'WslClipboard',
--   copy = {
--     ['+'] = 'clip.exe',
--     ['*'] = 'clip.exe',
--   },
--   paste = {
--     ['+'] = 'powershell.exe -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r", ""))',
--     ['*'] = 'powershell.exe -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r", ""))',
--     ['+'] = 'powershell.exe -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r", ""))',
--     ['*'] = 'powershell.exe -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r", ""))',
--   },
--   cache_enabled = 0,
-- }
--   },
--   cache_enabled = 0,
-- }

vim.opt.clipboard = 'unnamedplus'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.signcolumn = 'yes'
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.colorcolumn = "100"

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.showmatch = true
vim.opt.isfname:append("@-@")
vim.opt.iskeyword:append("-")

vim.opt.updatetime = 60

vim.g.mapleader = " "

vim.opt.cursorline = true

vim.o.foldmethod = "indent"
-- don't start with folds closed
vim.o.foldenable = false

vim.o.undofile = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autochdir = false

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.copilot_enabled = true
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
vim.opt.laststatus = 3
