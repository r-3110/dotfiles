--@see https://github.com/georgesnoe/lazygithub.nvim
--@see https://github.com/skanehira/github-actions.nvim

---@type LazyPluginSpec[]
return {
	{
		"georgesnoe/lazygithub.nvim",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			---@module "lazygithub"
			require("lazygithub").setup({
				border = "single", -- valid options are "single" | "double" | "shadow" | "curved"
			})
		end,
		event = "VeryLazy",
		keys = {
			{
				"<leader>lg",
				function()
					require("lazygithub").open()
				end,
				desc = "Open Lazygithub",
			},
		},
	},
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
