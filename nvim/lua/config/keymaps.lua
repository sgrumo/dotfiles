vim.g.mapleader = " "

local map = vim.keymap.set

map({ "n", "v" }, "<leader>d", [["_d]])

map("x", "<leader>p", [["_dP]])

-- Half page jumping with centered cursor
map("n", "<C-d>", "<C-d>zz") -- Down half page, center
map("n", "<C-u>", "<C-u>zz") -- Up half page, center

-- Search with centered results
map("n", "n", "nzzzv") -- Next search result, center
map("n", "N", "Nzzzv") -- Previous search result, center

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
