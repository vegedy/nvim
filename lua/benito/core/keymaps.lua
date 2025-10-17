local map = vim.keymap.set
map("n", "<leader>qh", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>bh", ":bp<CR>", { desc = "Go to previous buffer" })
map("n", "<leader>bl", ":bn<CR>", { desc = "Go to next buffer" })

vim.keymap.set('v', '<leader>x', ':norm $x<CR>', {
    desc = "Delete last character in visual selection",
    noremap = true,
    silent = true
})

