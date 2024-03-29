return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "lua", "vimdoc", "javascript", "typescript", "html" },
			sync_install = false,
			highlight = { enable = true },
		})
	end
}
