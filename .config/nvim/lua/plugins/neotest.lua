-- @see https://github.com/marilari88/neotest-vitest

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-python",
	},
	event = "BufReadPre",
	---@type neotest.CoreConfig
	---@diagnostic disable-next-line
	opts = {
		adapters = {
			---@type neotest.VitestOptions
			["neotest-vitest"] = {},
			---@type neotest-python.AdapterConfig
			["neotest-python"] = {},
		},
	},
}
