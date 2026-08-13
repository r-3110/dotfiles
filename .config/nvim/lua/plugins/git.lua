--@see https://github.com/niekdomi/conflict.nvim
--@see https://github.com/linrongbin16/gitlinker.nvim
--@see https://github.com/sindrets/diffview.nvim
--@see https://github.com/h3pei/trace-pr.nvim
--@see https://github.com/muellan/nvim-fold-hunks
--@see https://github.com/tominaga-h/hunk-inline.nvim

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
	{
		"muellan/nvim-fold-hunks",
		dependencies = { "lewis6991/gitsigns.nvim" },
		opts = {}, -- setup() is optional
		keys = {
			{
				"gz",
				function()
					---@module "hunkfold"
					require("hunkfold").toggle()
				end,
				desc = "Fold to git hunks",
			},
		},
	},
	{
		"tominaga-h/hunk-inline.nvim",
		event = "BufReadPost",
		config = function()
			---@module "hunk-inline"
			local hunk = require("hunk-inline")

			vim.keymap.set("n", "<leader>hc", hunk.add_comment, { desc = "Hunk: add inline comment" })
			vim.keymap.set("n", "<leader>hr", function()
				hunk.refresh_comments(false)
			end, { desc = "Hunk: refresh hunk comments" })
			vim.keymap.set("n", "<leader>hx", hunk.clear_comments, { desc = "Hunk: clear display" })

			-- Automatic fetch when viewing files (*Pass true if you want to suppress error notifications during automatic updates)
			vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
				pattern = "*",
				callback = function()
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(0) then
							hunk.refresh_comments(true)
						end
					end)
				end,
			})
		end,
	},
}
