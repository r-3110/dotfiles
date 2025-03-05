-- themeの設定
return {
	{
		"ellisonleao/gruvbox.nvim",
		"cocopon/iceberg.vim",
		"Mofiqul/dracula.nvim",
	},
	{
		"LazyVim/LazyVim",
		--- @type LazyVimConfig
		--- @diagnostic disable-next-line
		opts = {
			colorscheme = "dracula",
		},
	},
}
