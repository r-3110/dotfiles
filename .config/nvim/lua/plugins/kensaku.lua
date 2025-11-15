--@see https://github.com/lambdalisue/vim-kensaku

---@type LazyPluginSpec[]
return {
	{ "lambdalisue/kensaku.vim", dependencies = { "vim-denops/denops.vim" } },
	{
		"lambdalisue/kensaku-search.vim",
		dependencies = { "lambdalisue/kensaku.vim" },
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
	},
}
