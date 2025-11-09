-- @see https://github.com/nvim-neotest/neotest
-- @see https://github.com/marilari88/neotest-vitest
-- @see https://github.com/nvim-neotest/neotest-python

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
	config = function(_, opts)
		---@module "neotest"
		---@type neotest.Config
		--- @diagnostic disable-next-line: missing-fields
		require("neotest").setup({
			adapters = {
				---@module "neotest-vitest"
				require("neotest-vitest"),
				---@module "neotest-python"
				require("neotest-python"),
			},
		})
	end,
}
