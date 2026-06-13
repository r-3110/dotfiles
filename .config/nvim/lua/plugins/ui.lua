--@see https://github.com/nvim-mini/mini.cursorword
--@see https://github.com/petertriho/nvim-scrollbar

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
}
