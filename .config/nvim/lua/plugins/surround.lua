--@see https://github.com/kylechui/nvim-surround

---@type LazyPluginSpec
return {
	"kylechui/nvim-surround",
	version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	lazy = true,
	config = function()
		---@module "nvim-surround"
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
