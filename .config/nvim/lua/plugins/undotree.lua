return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        vim.o.undofile = true
        local undodir = vim.fn.expand('~/.config/nvim/.undo')

        if vim.fn.isdirectory(undodir) == 0 then
            vim.fn.mkdir(undodir, 'p')
        end

        vim.opt.undodir = undodir
    end
}
