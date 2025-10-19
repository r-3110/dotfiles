--@see https://github.com/vuki656/package-info.nvim

---@type LazyPluginSpec
return {
	"vuki656/package-info.nvim",
	event = "VeryLazy",
	lazy = true,
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		---@module "package-info"
		require("package-info").setup()
	end,
}
