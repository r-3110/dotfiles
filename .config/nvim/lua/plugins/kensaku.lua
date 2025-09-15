--@see https://github.com/lambdalisue/vim-kensaku

---@type LazyPluginSpec
return {
	"lambdalisue/kensaku.vim",
	{
		"lambdalisue/kensaku-search.vim",
		config = function()
			vim.api.nvim_set_keymap(
				"c",
				"<CR>",
				"<Plug>(kensaku-search-replace)<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
