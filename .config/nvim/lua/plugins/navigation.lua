--@see https://github.com/stevearc/aerial.nvim

---@type LazyPluginSpec[]
return {
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		---@module "aerial"
		opts = {},
	},
}
