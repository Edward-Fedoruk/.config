return {
    { 'fdschmidt93/telescope-egrepify.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                extensions = {
                    egrepify = {
                        -- intersect tokens in prompt ala "str1.*str2" that ONLY matches
                        -- if str1 and str2 are consecutively in line with anything in between (wildcard)
                        AND = true,                   -- default
                        permutations = false,         -- opt-in to imply AND & match all permutations of prompt tokens
                        lnum = true,                  -- default, not required
                        lnum_hl = "EgrepifyLnum",     -- default, not required, links to `Constant`
                        col = false,                  -- default, not required
                        col_hl = "EgrepifyCol",       -- default, not required, links to `Constant`
                        title = true,                 -- default, not required, show filename as title rather than inline
                        filename_hl = "EgrepifyFile", -- default, not required, links to `Title`
                        -- suffix = long line, see screenshot
                        -- EXAMPLE ON HOW TO ADD PREFIX!
                        prefixes = {
                            -- ADDED ! to invert matches
                            -- example prompt: ! sorter
                            -- matches all lines that do not comprise sorter
                            -- rg --invert-match -- sorter
                            ["!"] = {
                                flag = "invert-match",
                            },
                            -- HOW TO OPT OUT OF PREFIX
                            -- ^ is not a default prefix and safe example
                            ["^"] = false
                        },
                    }
                },
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case'
                    },
                    path_display = { "smart" },
                    mappings = {
                        n = {
                            ["dd"] = require('telescope.actions').delete_buffer,
                            ["q"] = require('telescope.actions').close,
                        }
                    }
                }
            }
            require "telescope".load_extension "egrepify"
            vim.keymap.set("n", "<leader>fb",
                function()
                    require('telescope.builtin').buffers({ sort_lastused = true, sort_mru = true })
                end,
                {})

            vim.keymap.set("n", "<leader>ff",
                function()
                    require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
                        defaults = {
                            path_display = { "smart" }
                        },
                        previewer = false
                    }))
                end,
                {})


            vim.keymap.set("n", "<Leader>f", ":Telescope egrepify<CR>", {})
            vim.keymap.set('n', '<Leader>fr', function()
                    require('telescope.builtin').lsp_references()
                end,
                {})
        end
    }
}
