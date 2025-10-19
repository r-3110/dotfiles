--@see https://github.com/nekowasabi/hellshake-yano.vim

---@type LazyPluginSpec[]
return {
	{
		"nekowasabi/hellshake-yano.vim",
		event = "VeryLazy",
		lazy = true,
		init = function()
			vim.g.hellshake_yano = {
				useJapanese = true,
				useTinySegmenter = true,
				perKeyMinLength = {
					v = 1,
					w = 3,
					e = 2,
				},
				enableHighlight = true,
			}
		end,
	},
}
