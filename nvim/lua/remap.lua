vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("x", "<leader>p", [["_dP]])

-- Half page jumping with centered cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Down half page, center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Up half page, center

-- Search with centered results
vim.keymap.set("n", "n", "nzzzv") -- Next search result, center
vim.keymap.set("n", "N", "Nzzzv") -- Previous search result, center

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
