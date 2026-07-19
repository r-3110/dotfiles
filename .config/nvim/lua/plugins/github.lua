--@see https://github.com/skanehira/github-actions.nvim
--@see https://github.com/justinmk/guh.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"skanehira/github-actions.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
		},
		event = {
			{
				event = { "BufReadPre", "BufNewFile" },
				pattern = "**/.github/workflows/*",
			},
		},
		---@module "github-actions"
		opts = {},
	},
	{
		"justinmk/guh.nvim",
		cmd = "Guh",
	},
}
