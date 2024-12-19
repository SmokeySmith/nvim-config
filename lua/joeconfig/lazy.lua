local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = "joeconfig.plugins",
    change_detection = { notify = false }
})

vim.keymap.set("n", "<leader>ll", function() vim.cmd(":Lazy") end)
vim.keymap.set("n", "<leader>ls", function() vim.cmd(":Lazy sync") end)
vim.keymap.set("n", "<leader>lh", function() vim.cmd(":Lazy health") end)
