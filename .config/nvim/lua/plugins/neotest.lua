-- @see https://github.com/marilari88/neotest-vitest

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
	},
	event = "BufReadPre",
	opts = {
		adapters = {
			["neotest-vitest"] = {},
		},
	},
}
