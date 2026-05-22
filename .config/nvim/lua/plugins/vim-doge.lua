-- @see https://github.com/kkoomen/vim-doge

---@modle "lazy"
---@type LazyPluginSpec
return {
	"kkoomen/vim-doge",
	event = "BufReadPre",
	lazy = true,
	keys = {
		{
			"<Leader>dog",
			function()
				vim.cmd("DogeGenerate")
			end,
			desc = "Doge ドキュメント生成",
		},
	},
}

-- Interactive mode comment todo-jumping
-- vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
-- vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
-- vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
