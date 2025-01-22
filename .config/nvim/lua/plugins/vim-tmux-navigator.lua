return {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
        require('smart-splits').setup({
            resize_amounts = {
                default = 1,
                left = 1,
                right = 1,
                up = 1,
                down = 1,
            },
        })
        -- Navigate splits more intelligently
        vim.keymap.set('n', '<c-h>', function() require('smart-splits').move_cursor_left() end, { silent = true })
        vim.keymap.set('n', '<c-j>', function() require('smart-splits').move_cursor_down() end, { silent = true })
        vim.keymap.set('n', '<c-k>', function() require('smart-splits').move_cursor_up() end, { silent = true })
        vim.keymap.set('n', '<c-l>', function() require('smart-splits').move_cursor_right() end, { silent = true })
        -- Resize splits with META + Arrow keys
        vim.keymap.set('n', '<A-Left>', function() require('smart-splits').resize_left() end, { silent = true })
        vim.keymap.set('n', '<A-Down>', function() require('smart-splits').resize_down() end, { silent = true })
        vim.keymap.set('n', '<A-Up>', function() require('smart-splits').resize_up() end, { silent = true })
        vim.keymap.set('n', '<A-Right>', function() require('smart-splits').resize_right() end, { silent = true })
    end

}
