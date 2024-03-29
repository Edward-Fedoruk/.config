return {
	{ "lukas-reineke/lsp-format.nvim" },
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
				capabilities = capabilities
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = require("lsp-format").on_attach
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
				flags = { debounce_text_changes = 500 },
				on_attach = function(client)
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
				end,
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
				ensure_installed = { "lua_ls", "tsserver" },
			}
		end
	},
}
