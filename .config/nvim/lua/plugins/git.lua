--@see https://github.com/akinsho/git-conflict.nvim
--@see https://github.com/linrongbin16/gitlinker.nvim
--@see https://github.com/sindrets/diffview.nvim
--@see https://github.com/h3pei/trace-pr.nvim

---@module "lazynvim"
---@type LazyPluginSpec[]
return {
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		lazy = true,
		version = "*",
		config = true,
	},
	{
		"linrongbin16/gitlinker.nvim",
		event = "VeryLazy",
		lazy = true,
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		lazy = true,
	},
	{ "h3pei/trace-pr.nvim", event = "VeryLazy", config = true },
}
