vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = '#f2cdcd' })
		local dashboardColor = '#f5e0dc'
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = '#f2cdcd' })
		vim.api.nvim_set_hl(0, "DashboardProjectTitle", { fg = dashboardColor, })
		vim.api.nvim_set_hl(0, "DashboardProjectTitleIcon", { fg = dashboardColor, })
		vim.api.nvim_set_hl(0, "DashboardProjectIcon", { fg = dashboardColor, })
		vim.api.nvim_set_hl(0, "DashboardMruTitle", { fg = dashboardColor, })
		vim.api.nvim_set_hl(0, "DashboardMruIcon", { fg = dashboardColor, })
		vim.api.nvim_set_hl(0, "DashboardFiles", { fg = '#cdd6f4', })
		vim.api.nvim_set_hl(0, "DashboardShortCutIcon", { fg = dashboardColor, }) -- Repeat for other highlights...
	end
})
return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			config = {
				week_header = {
					enable = true, --boolean use a week header
				},
				project = { enable = true, limit = 10 },
				mru = { enable = false, limit = 5 },
				footer = {},
				packages = { enable = false },
				shortcut = {
					{ desc = 'Update Plugins', group = 'DashboardShortCut', action = 'Lazy update', key = 'u' },
				},
				preview = {
					command = '',
					file_path = nil,
					file_height = 3,
					file_width = 3,
				},

			}, -- config,
			disable_move = true
		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
