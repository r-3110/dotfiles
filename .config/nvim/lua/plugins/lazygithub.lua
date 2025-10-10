--@see https://github.com/georgesnoe/lazygithub.nvim
return {
	"georgesnoe/lazygithub.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	config = function()
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
}
