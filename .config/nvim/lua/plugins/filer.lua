--@see https://github.com/stevearc/oil.nvim

---@type LazyPluginSpec[]
return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		---@module "oil"
		---@type oil.SetupOpts
		opts = {},
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	},
}
