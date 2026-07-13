--@see https://github.com/skanehira/github-actions.nvim
--@see https://github.com/justinmk/guh.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"skanehira/github-actions.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- Optional: for enhanced workflow selection
		},
		event = "VeryLazy",
		---@module "github-actions"
		opts = {},
	},
	{
		"justinmk/guh.nvim",
		event = "VeryLazy",
	},
}
