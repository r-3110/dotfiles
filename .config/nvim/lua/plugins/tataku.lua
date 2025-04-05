-- @see https://github.com/Omochice/tataku.vim

return {
	{
		"Omochice/tataku.vim",
		dependencies = {
			{ "vim-denops/denops.vim" },
		},
		event = "VeryLazy",
		config = function()
			vim.g.tataku_recipes = {
				-- 翻訳 en => ja
				translate = {
					collector = { name = "current_line" },
					processor = {
						{ name = "google_translate", options = { source = "en", target = "ja" } },
					},
					emitter = { name = "echo" },
				},
			}
		end,
	},
	{
		"Omochice/tataku-collector-current_line",
	},
	{
		"Omochice/tataku-processor-google_translate",
	},
	{
		"Omochice/tataku-emitter-echo",
	},
}
