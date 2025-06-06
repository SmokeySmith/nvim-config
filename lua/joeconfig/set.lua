--vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.g.have_nerd_font = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.signcolumn = 'yes'
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 60

vim.opt.colorcolumn = "100"

vim.g.mapleader = " "

vim.opt.cursorline = true

vim.o.foldmethod = "indent"
-- don't start with folds closed
vim.o.foldenable = false
-- set undofile
-- local function getUndoDir()
--   if vim.fn.has('win32') == 1 then
--     return '%AppData%/Local/nvim/nvim_user_data/undo'
--   else
--     return '.config/nvim_user_data/undo'
--   end
-- end
--
-- vim.o.undodir = getUndoDir()
vim.o.undofile = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.copilot_enabled = false
-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = "*.ts,*tsx,*.js,*.jsx",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local clients = vim.lsp.get_clients({ bufnr = bufnr })
--
--     local is_deno_project = vim.fn.filereadable("deno.json") == 1 or
--         vim.fn.filereadable("deno.json") == 1
--
--     if is_deno_project then
--       for _, c in ipairs(clients) do
--         if c.name == 'ts_ls' or c.name == 'tsserver' then
--           vim.lsp.buf_detach_client(bufnr, c.id)
--           vim.notify('Detached ts_ls inside deno project', vim.log.levels.INFO)
--         end
--       end
--     end
--   end
-- })
