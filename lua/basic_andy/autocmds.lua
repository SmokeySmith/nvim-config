local function augroup(name)
  return vim.api.nvim_create_augroup("basic_andy_" .. name, { clear = true })
end

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return to the last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore last cursor position",
  group = augroup("last_loc"),
  callback = function(args)
    if vim.bo[args.buf].filetype == "gitcommit" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim trailing whitespace",
  group = augroup("trim_whitespace"),
  callback = function()
    if vim.bo.filetype == "markdown" then
      return -- trailing double-space is a hard line break
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Create missing parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto-create parent directories",
  group = augroup("auto_mkdir"),
  callback = function(args)
    if args.match:match("^%w%w+://") then
      return -- not a real path (oil://, fugitive://, ...)
    end
    local dir = vim.fn.fnamemodify(vim.uv.fs_realpath(args.match) or args.match, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})

-- q closes transient windows
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close scratch windows with q",
  group = augroup("close_with_q"),
  pattern = { "help", "man", "qf", "checkhealth", "lspinfo", "query", "startuptime" },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})

-- Wrap and spellcheck prose
vim.api.nvim_create_autocmd("FileType", {
  desc = "Prose settings",
  group = augroup("prose"),
  pattern = { "markdown", "gitcommit", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Per-filetype indentation where 2 spaces is wrong
vim.api.nvim_create_autocmd("FileType", {
  desc = "Filetype indent overrides",
  group = augroup("indent"),
  pattern = { "python", "rust", "scala", "java", "c", "cpp", "cs" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Go uses real tabs",
  group = augroup("indent_go"),
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check for external file changes",
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})
