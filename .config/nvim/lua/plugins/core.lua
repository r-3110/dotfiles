-- themeの設定
---@type LazyPluginSpec
return {
	"LazyVim/LazyVim",
	dependencies = {
		"rebelot/kanagawa.nvim",
		"folke/tokyonight.nvim",
		"Mofiqul/dracula.nvim",
	},
	---@module "lazyvim"
	---@param opts LazyVimOptions
	opts = function(_, opts)
		-- 候補のcolorscheme一覧
		local themes = { "kanagawa", "tokyonight", "dracula" }

		-- ランダム選択
		math.randomseed(os.time())
		local choice = themes[math.random(#themes)]

		opts.colorscheme = choice

		return opts
	end,
}
