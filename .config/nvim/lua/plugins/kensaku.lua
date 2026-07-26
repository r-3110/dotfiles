--@see https://github.com/lambdalisue/vim-kensaku
--@see https://github.com/yuki-yano/fuzzy-motion.vim

---@type LazyPluginSpec[]
return {
	-- searchやcommand時の遅延読み込みだと動作が遅くなるため、起動時に読み込む
	{
		"lambdalisue/kensaku.vim",
		dependencies = { "vim-denops/denops.vim" },
	},
	{
		"lambdalisue/kensaku-search.vim",
		dependencies = { "lambdalisue/kensaku.vim" },
		keys = {
			{ "/", mode = "n" },
		},
		config = function()
			vim.api.nvim_set_keymap(
				"c",
				"<CR>",
				"<Plug>(kensaku-search-replace)<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"lambdalisue/kensaku-command.vim",
		dependencies = { "lambdalisue/kensaku.vim" },
		event = "CmdlineEnter",
	},
	{
		"yuki-yano/fuzzy-motion.vim",
		dependencies = { "lambdalisue/kensaku.vim" },
		event = "VeryLazy",
		keys = {
			{
				"<C-j>",
				"<Cmd>FuzzyMotion<CR>",
				desc = "Fuzzy Motion",
			},
		},
		init = function()
			vim.g.fuzzy_motion_matchers = { "fzf", "kensaku" }
		end,
	},
}
