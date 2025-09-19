-- @type https://github.com/scottmckendry/cyberdream.nvim

-- themeの設定
---@type LazyPluginSpec
return {
	"LazyVim/LazyVim",
	dependencies = {
		"ellisonleao/gruvbox.nvim",
		"cocopon/iceberg.vim",
		"Mofiqul/dracula.nvim",
		{
			"scottmckendry/cyberdream.nvim",
			lazy = false,
			priority = 1000,
			---@type cyberdream.Config
			opts = {},
		},
	},
	--- @type LazyVimConfig
	--- @diagnostic disable-next-line: missing-fields
	opts = {
		colorscheme = "dracula",
	},
}
