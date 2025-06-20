-- @see https://github.com/m4xshen/hardtime.nvim
---@type LazyPluginSpec
return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	lazy = false,
	event = "VeryLazy",
	opts = {
		enabled = true,
	},
}
