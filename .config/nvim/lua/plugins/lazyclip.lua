-- @see https://github.com/atiladefreitas/lazyclip

---@type LazyPluginSpec
return {
	"atiladefreitas/lazyclip",
	config = function()
		---@module "lazyclip"
		require("lazyclip").setup({
			-- your custom config here (optional)
		})
	end,
	keys = {
		{ "Cw", desc = "Open Clipboard Manager" },
	},
	-- Optional: Load plugin when yanking text
	event = { "TextYankPost" },
}
