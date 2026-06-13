--@see https://github.com/stevearc/aerial.nvim
--@see https://github.com/Bekaboo/dropbar.nvim

---@type LazyPluginSpec[]
return {
	{
		"stevearc/aerial.nvim",
		cmd = "AerialOpen",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		---@module "aerial"
		opts = {},
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
}
