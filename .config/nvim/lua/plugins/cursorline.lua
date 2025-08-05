--@see https://github.com/ya2s/nvim-cursorline

--- 同期で読み込まないと動かない
---@type LazyPluginSpec
return {
	"ya2s/nvim-cursorline",
	config = function()
		require("nvim-cursorline").setup({
			cursorline = {
				enable = true,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 1,
				hl = { underline = true },
			},
		})
	end,
}
