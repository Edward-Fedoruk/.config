return {
    { "lukas-reineke/lsp-format.nvim" },
    {
        "antosha417/nvim-lsp-file-operations",
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                filetypes = { "html", "ejs", "typescriptreact", "javascriptreact" },
                capabilities = capabilities
            })
            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = {
                    "css",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "less",
                    "sass",
                    "typescript",
                    "scss",
                    "typescriptreact",
                },
                init_options = {
                    html = {
                        options = {
                            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                            ["bem.enabled"] = true,
                        },
                    },
                },
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = require("lsp-format").on_attach
            })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                filetypes = { "html", "css", "ejs", "javascriptreact", "typescriptreact", "vue", "svelte" },
            })
            local util = require("lspconfig/util")

            local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }

            local function root_has_file(files)
                local cwd = vim.fn.getcwd()
                for _, file in ipairs(files) do
                    if util.path.exists(util.path.join(cwd, file)) then
                        return true
                    end
                end
                return false
            end

            lspconfig.eslint.setup({
                capabilities = capabilities,
                flags = { debounce_text_changes = 500 },
                on_attach = function(client)
                    if not root_has_file(prettier_root_files) then
                        client.server_capabilities.documentFormattingProvider = true
                        if client.server_capabilities.documentFormattingProvider then
                            local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                pattern = "*",
                                callback = function()
                                    vim.lsp.buf.format({})
                                end,
                                group = au_lsp,
                            })
                        end
                    end
                end
            })

            vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '<Leader>h', vim.lsp.buf.hover, {})
            vim.keymap.set('n', '<Leader>d', vim.lsp.buf.definition, {})
            vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, {})
            for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
                vim.fn.sign_define("DiagnosticSign" .. diag, {
                    text = "",
                    texthl = "DiagnosticSign" .. diag,
                    linehl = "",
                    numhl = "DiagnosticSign" .. diag,
                })
            end
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = 'rounded',
                    close_events = { "BufHidden", "InsertLeave" },
                }
            )

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = 'rounded',
                }
            )
            vim.diagnostic.config({
                virtual_text = false,
                underline = true,
                signs = true,
                update_in_insert = true,
                float = { border = "rounded" },
            })
            -- Show line diagnostics automatically in hover window
            vim.o.updatetime = 50
            -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup({
                ui = {
                    border = 'single'
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "tailwindcss", "lua_ls", "cssls" },
            }
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            jsx_close_tag = {
                enable = true,
                filetypes = { "javascriptreact", "typescriptreact" },
            }
        },
        config = function()
            vim.keymap.set('n', '<Leader>di', ':TSToolsRemoveUnusedImports<CR>', { noremap = true, silent = true })
        end
    }
}
