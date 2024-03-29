return {
    "sindrets/diffview.nvim",
    config = function()
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<leader>vd', '<cmd>DiffviewFileHistory %<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vdc', '<cmd>DiffviewClose<CR>', opts)
    end
}
