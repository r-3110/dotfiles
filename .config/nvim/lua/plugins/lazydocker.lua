-- @see https://github.com/crnvl96/lazydocker.nvim

return {
	"crnvl96/lazydocker.nvim",
	event = "VeryLazy",
	opts = {}, -- automatically calls `require("lazydocker").setup()`
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
