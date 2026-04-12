--@see https://github.com/skanehira/github-actions.nvim

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
}
