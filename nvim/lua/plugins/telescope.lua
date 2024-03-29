return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>ff",
            "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
            {})
        vim.api.nvim_set_keymap("n", "<Leader>f", ":Telescope live_grep<CR>", {})
    end
}
