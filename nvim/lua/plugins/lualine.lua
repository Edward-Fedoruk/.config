return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                theme = "catppuccin"
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diagnostics' },
                lualine_c = { 'buffers' },
                lualine_x = { 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            }
        })
    end
}
