return {
    'sbdchd/neoformat',
    config = function()
        vim.g.neoformat_enabled_javascript = { 'prettier' }
        vim.g.neoformat_enabled_typescript = { 'prettier' }
        vim.g.neoformat_enabled_json = { 'prettier' }

        vim.g.neoformat_javascript_prettier = {
            exe = "prettier",
            args = { "--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)) },
            stdin = 1
        }

        local function has_prettier_config()
            local configs = { ".prettierrc", ".prettierrc.js", ".prettierrc.json", "prettier.config.js",
                ".prettier.config.js" }
            for _, config in ipairs(configs) do
                if vim.fn.filereadable(vim.fn.findfile(config, '.;')) == 1 then
                    return true
                end
            end
            return false
        end

        function _G.conditional_neoformat()
            if has_prettier_config() then
                vim.cmd("Neoformat")
            else
                vim.api.nvim_out_write("Skipping Neoformat: No Prettier config file found in project root.\n")
            end
        end

        vim.api.nvim_exec(
            [[
                augroup fmt
                  autocmd!
                  autocmd BufWritePre * lua conditional_neoformat()

                augroup END
            ]],
            false
        )
    end
}
