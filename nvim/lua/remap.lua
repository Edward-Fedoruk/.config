vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set nowrap")
vim.cmd("set clipboard=unnamed")

vim.opt.scrolloff = 15
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.g.mapleader = ' '
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

local options = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)
vim.keymap.set('n', '<leader>ln', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true, desc = "Toggle Relative Numbers" })
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>', {})
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('n', '<Leader>s', ':w<CR>')
vim.keymap.set('i', 'jk', '<Esc>', options)
-- Move lines up
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", options)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", options)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", options)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", options)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", options)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", options)
-- resize window
vim.keymap.set('n', '<A-Up>', ':resize -2<CR>', options)
vim.keymap.set('n', '<A-Down>', ':resize +2<CR>', options)
vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', options)
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', options)
-- Indent
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
