--@see https://github.com/niekdomi/conflict.nvim
--@see https://github.com/linrongbin16/gitlinker.nvim
--@see https://github.com/sindrets/diffview.nvim
--@see https://github.com/h3pei/trace-pr.nvim

---@module "lazynvim"
---@type LazyPluginSpec[]
return {
	{
		"niekdomi/conflict.nvim",
		config = function()
			---@module "conflict"
			---@type ConflictConfig
			require("conflict").setup({
				default_mappings = {
					current = "<leader>gxc",
					incoming = "<leader>gxt",
					both = "<leader>gxb",
					base = "<leader>gxB",
					none = "<leader>gx0",
					next = "]x",
					prev = "[x",
				},
				show_actions = true, -- Show clickable [Accept Current | ...] labels
				disable_diagnostics = true, -- Disable LSP/Diagnostics while conflicts exist
				highlights = {
					-- Names of highlight groups to use for sections
					current = "DiffText",
					incoming = "DiffAdd",
					ancestor = "DiffChange",
				},
			})
		end,
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
