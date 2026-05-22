-- @see https://github.com/nvim-neotest/neotest
-- @see https://github.com/marilari88/neotest-vitest
-- @see https://github.com/nvim-neotest/neotest-python
-- @see https://github.com/fredrikaverpil/neotest-golang

---@module "lazy"
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
		"fredrikaverpil/neotest-golang",
	},
	lazy = true,
	event = "BufReadPre",
	keys = {
		{
			"<leader>ts",
			function()
				vim.cmd("Neotest summary")
			end,
			desc = "Toggle test summary",
		},
	},
	config = function()
		---@module "neotest"
		---@type neotest.Config
		--- @diagnostic disable-next-line: missing-fields
		require("neotest").setup({
			adapters = {
				---@module "neotest-vitest"
				require("neotest-vitest"),
				---@module "neotest-python"
				require("neotest-python"),
				---@module "neotest-golang"
				require("neotest-golang"),
			},
		})
	end,
}
