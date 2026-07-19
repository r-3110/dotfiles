--@see https://github.com/niekdomi/conflict.nvim
--@see https://github.com/linrongbin16/gitlinker.nvim
--@see https://github.com/sindrets/diffview.nvim
--@see https://github.com/h3pei/trace-pr.nvim

---@module "lazynvim"
---@type LazyPluginSpec[]
return {
	{
		"niekdomi/conflict.nvim",
		event = "BufReadPost",
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
		cmd = "GitLink",
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
		},
	},
	{ "h3pei/trace-pr.nvim", cmd = "TracePR", config = true },
}
