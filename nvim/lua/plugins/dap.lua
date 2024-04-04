return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'theHamsta/nvim-dap-virtual-text',
                config = function()
                    require("nvim-dap-virtual-text").setup()
                end
            },
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                -- stylua: ignore
                keys = {
                    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                    { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
                opts = {
                    layouts = {
                        {
                            elements = {
                                {
                                    id = "scopes",
                                    size = 0.25
                                },
                                {
                                    id = "breakpoints",
                                    size = 0.25
                                },
                            },
                            position = "left",
                            size = 40
                        },
                        {
                            elements = {
                                {
                                    id = "console",
                                    size = 1
                                }
                            },
                            position = "bottom",
                            size = 10
                        }
                    },
                },
                config = function(_, opts)
                    local dap = require("dap")
                    local dapui = require("dapui")
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        vim.cmd.Neotree('close')
                        dapui.open({})
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close({})
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close({})
                    end
                end,
            },
        },
        config = function()
            vim.keymap.set('n', '<Leader>dc', function()
                vim.cmd.Neotree('close')
                require('dap').continue()
            end)
            vim.keymap.set('n', '<Leader>do', function() require('dap').step_over() end)
            vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
            vim.keymap.set('n', '<Leader>do', function() require('dap').step_out() end)
            vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>dq', function() require('dap').close() end)
            vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)

            local dap = require("dap")

            if not dap.adapters["pwa-node"] then
                require("dap").adapters["pwa-node"] = {
                    type = "server",
                    host = "127.0.0.1",
                    port = "9229",
                    executable = {
                        command = "node",
                        -- 💀 Make sure to update this path to point to your installation
                        args = {
                            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                            .. "/js-debug/src/dapDebugServer.js",
                            "9229",
                        },
                    },
                }
            end
            for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
                if not dap.configurations[language] then
                    dap.configurations[language] = {
                        {
                            type = "pwa-node",
                            request = "launch",
                            name = "Launch file",
                            program = "${file}",
                            cwd = "${workspaceFolder}",
                        },
                        {
                            type = "pwa-node",
                            request = "attach",
                            name = "Attach",
                            processId = require("dap.utils").pick_process,
                            cwd = "${workspaceFolder}",
                        },
                    }
                end
            end
        end,
    },
}
