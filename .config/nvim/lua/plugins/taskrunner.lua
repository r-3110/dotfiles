--@see https://github.com/stevearc/overseer.nvim

---@type LazyPluginSpec
return {
	"stevearc/overseer.nvim",
	keys = {
		{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
		{ "<leader>to", "<cmd>OverseerOpen<cr>", desc = "Open Task Runner" },
		{ "<leader>tc", "<cmd>OverseerClose<cr>", desc = "Close Task Runner" },
	},
	---@module "overseer"
	---@type overseer.SetupOpts
	opts = {},
}
