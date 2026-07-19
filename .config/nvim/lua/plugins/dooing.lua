-- @see https://github.com/atiladefreitas/dooing

---@type LazyPluginSpec
return {
	"atiladefreitas/dooing",
	cmd = { "Dooing" },
	config = function()
		---@module "dooing"
		require("dooing").setup({
			-- your custom config here (optional)
		})
	end,
}
