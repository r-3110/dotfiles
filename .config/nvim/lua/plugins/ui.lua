--@see https://github.com/nvim-mini/mini.cursorword

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
}
