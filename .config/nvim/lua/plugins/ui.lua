--@see https://github.com/nvim-mini/mini.cursorword
--@see https://github.com/petertriho/nvim-scrollbar
--@see https://github.com/catgoose/nvim-colorizer.lua

---@type LazyPluginSpec[]
return {
	{
		"nvim-mini/mini.cursorword",
		version = "*",
		config = function()
			---@module "mini.cursorword"
			require("mini.cursorword").setup({})
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			---@module "scrollbar"
			require("scrollbar").setup({})
			---@module "scrollbar.handlers.gitsigns"
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		---@module "colorizer"
		---@type colorizer.Options
		---@diagnostic disable-next-line: missing-fields
		opts = {},
	},
}
