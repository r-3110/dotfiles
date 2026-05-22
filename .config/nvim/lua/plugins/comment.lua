-- @see https://github.com/numToStr/Comment.nvim
-- @see https://github.com/folke/ts-comments.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {
			-- add any options here
		},
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
