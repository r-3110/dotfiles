-- @see https://github.com/atiladefreitas/dooing

---@type LazyPluginSpec
return {
	"atiladefreitas/dooing",
	lazy = true,
	event = "VeryLazy",
	config = function()
		---@module "dooing"
		require("dooing").setup({
			-- your custom config here (optional)
		})
	end,
}
