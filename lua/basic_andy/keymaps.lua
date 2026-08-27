local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "[B]uffer [d]elete" })
map("n", "<leader>`", "<cmd>b#<CR>", { desc = "Last buffer" })

-- Move selected lines, reindenting as they go
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Paste over a selection without clobbering the unnamed register
map("x", "<leader>p", '"_dP', { desc = "[P]aste without yanking" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete without yanking" })

-- Keep the cursor centred on jumps and search hits
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Quickfix / location list
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Open quickfi[x] list" })
map("n", "[q", "<cmd>cprevious<CR>", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

-- Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

-- Save / quit
map("n", "<leader>w", "<cmd>write<CR>", { desc = "[W]rite file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "[Q]uit window" })

-- lazy.nvim
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "[L]azy" })

-- Disabled: too easy to hit by accident
map("n", "Q", "<nop>")
