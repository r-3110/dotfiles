-- @see https://github.com/Omochice/tataku.vim

---@type LazyPluginSpec[]
return {
	{
		"Omochice/tataku.vim",
		dependencies = {
			{ "vim-denops/denops.vim" },
			{
				"Omochice/tataku-collector-current_line",
			},
			{
				"Omochice/tataku-processor-google_translate",
			},
			{
				"Omochice/tataku-processor-split_by_displaywidth",
			},
			{
				"Omochice/tataku-emitter-nvim_floatwin",
			},
		},
		event = "VeryLazy",
		lazy = true,
		keys = {
			{
				"<leader>tt",
				function()
					vim.fn["tataku#call_recipe"]("translate")
				end,
				desc = "en => ja",
				noremap = true,
				silent = true,
			},
		},
		config = function()
			vim.g.tataku_recipes = {
				-- 翻訳 en => ja
				translate = {
					collector = { name = "current_line" },
					processor = {
						{ name = "google_translate", options = { source = "en", target = "ja" } },
						{ name = "split_by_displaywidth", options = { width = vim.o.columns } },
					},
					emitter = { name = "nvim_floatwin" },
				},
			}
		end,
	},
}
