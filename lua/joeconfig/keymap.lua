vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- greatest remap ever
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")


vim.keymap.set("n", "<leader>e", function()
    vim.cmd(":NvimTreeToggle")
end)
vim.keymap.set("n", "<leader>bd", function() vim.cmd(":bdelete") end)
vim.keymap.set("n", "<leader>bq", function() vim.cmd(":q") end)
vim.keymap.set("n", "<leader>qq", function() vim.cmd(":quitall") end)
vim.keymap.set("n", "<leader>qf", function() vim.cmd(":q!") end)
vim.keymap.set("n", "<leader>ll", function() vim.cmd(":Lazy") end)
vim.keymap.set("n", "<leader>ls", function() vim.cmd(":Lazy sync") end)
vim.keymap.set("n", "<leader>lh", function() vim.cmd(":Lazy health") end)
