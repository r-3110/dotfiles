-- themeの設定
return {
	---@type LazyPluginSpec
	{
		"ellisonleao/gruvbox.nvim",
		"cocopon/iceberg.vim",
		"Mofiqul/dracula.nvim",
	},
	---@type LazyPluginSpec
	{
		"LazyVim/LazyVim",
		--- @type LazyVimConfig
		--- @diagnostic disable-next-line: missing-fields
		opts = {
			colorscheme = "dracula",
		},
	},
}
