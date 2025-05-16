-- @see https://github.com/folke/snacks.nvim

---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	--- @type snacks.Config
	opts = {
		terminal = {
			win = {
				position = "float",
			},
		},
		lazygit = {},
	},
}
