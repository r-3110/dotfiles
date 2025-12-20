-- @see https://github.com/Omochice/tataku.vim

---@type LazyPluginSpec[]
return {
	{
		"Omochice/tataku.vim",
		dependencies = {
			{ "vim-denops/denops.vim" },
			{
				dir = "~/workspace/tataku-collector-v_range",
				dependencies = { "vim-denops/denops.vim" },
				lazy = false,
			},
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
				translate_v_range = {
					collector = { name = "v_range" },
					processor = {
						{ name = "google_translate", options = { source = "en", target = "ja" } },
						{ name = "split_by_displaywidth", options = { width = vim.o.columns } },
					},
				},
			}
		end,
	},
}
