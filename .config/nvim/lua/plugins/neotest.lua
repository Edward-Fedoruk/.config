return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        'nvim-neotest/neotest-jest',
    },
    config = function()
        require('neotest').setup({
            adapters = {
                require('neotest-jest')({
                    jestCommand = "npm test --",
                    env = { CI = true },
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end,
                }),
            }
        })

        local options = { noremap = true, silent = true }

        vim.keymap.set('n', '<Leader>t', ':lua require("neotest").run.run()<CR>', options)
        vim.keymap.set('n', '<Leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', options)
        vim.keymap.set('n', '<Leader>td', ':lua require("neotest").run.run({strategy = "dap"})<CR>', options)
        vim.keymap.set('n', '<Leader>to', ':lua require("neotest").output_panel.open()<CR>', options)
        vim.keymap.set('n', '<Leader>ts', ':lua require("neotest").summary.open()<CR>', options)
    end
}
