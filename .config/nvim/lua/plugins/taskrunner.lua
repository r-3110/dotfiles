--@see https://github.com/stevearc/overseer.nvim

---@module "lazy"
---@type LazyPluginSpec
return {
	"stevearc/overseer.nvim",
	keys = {
		{
			"<leader>tr",
			function()
				vim.cmd("OverseerRun")
			end,
			desc = "Run Task",
		},
		{
			"<leader>to",
			function()
				vim.cmd("OverseerToggle")
			end,
			desc = "Toggle Task Runner",
		},
	},
	---@module "overseer"
	---@type overseer.SetupOpts
	opts = {},
}
