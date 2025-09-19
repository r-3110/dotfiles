-- @type https://github.com/scottmckendry/cyberdream.nvim

-- themeの設定
---@type LazyPluginSpec
return {
	"LazyVim/LazyVim",
	dependencies = {
		"ellisonleao/gruvbox.nvim",
		"cocopon/iceberg.vim",
		"rebelot/kanagawa.nvim",
		"folke/tokyonight.nvim",
		"Mofiqul/dracula.nvim",
		{
			"scottmckendry/cyberdream.nvim",
			lazy = false,
			priority = 1000,
			---@type cyberdream.Config
			opts = {},
		},
	},
	--- @type LazyVimConfig | PluginOpts
	--- @diagnostic disable-next-line: missing-fields
	--- @param opts LazyVimConfig
	opts = function(_, opts)
		-- 候補のcolorscheme一覧
		local themes = { "gruvbox", "iceberg", "kanagawa", "tokyonight", "dracula", "cyberdream" }

		-- ランダム選択
		math.randomseed(os.time())
		local choice = themes[math.random(#themes)]

		opts.colorscheme = choice

		return opts
	end,
}
