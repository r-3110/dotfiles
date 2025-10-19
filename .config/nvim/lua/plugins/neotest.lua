-- @see https://github.com/marilari88/neotest-vitest

---@type LazyPluginSpec
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
	lazy = true,
	event = "BufReadPre",
	---@module "neotest"
	---@type neotest.CoreConfig
	--- @diagnostic disable-next-line: missing-fields
	opts = {
		log_level = vim.log.levels.DEBUG,
		adapters = {
			---@module "neotest-vitest"
			---@type neotest.VitestOptions
			["neotest-vitest"] = {},
			---@module "neotest-python"
			---@type neotest-python.AdapterConfig
			["neotest-python"] = {},
		},
	},
}
