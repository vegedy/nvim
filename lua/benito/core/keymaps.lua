local map = vim.keymap.set
map("n", "<leader>qh", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer", silent = true })
map("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer", silent = true })

vim.keymap.set('v', '<leader>x', ':norm $x<CR>', {
    desc = "Delete last character in visual selection",
    noremap = true,
    silent = true
})

