-- @see https://github.com/crnvl96/lazydocker.nvim

---@type LazyPluginSpec
return {
	"crnvl96/lazydocker.nvim",
	event = "VeryLazy",
	lazy = true,
	opts = {}, -- automatically calls `require("lazydocker").setup()`
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
