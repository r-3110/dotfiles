--@see https://github.com/MagicDuck/grug-far.nvim

---@type LazyPluginSpec
return {
	"MagicDuck/grug-far.nvim",
	-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
	-- additional lazy config to defer loading is not really needed...
	config = function()
		-- optional setup call to override plugin options
		-- alternatively you can set options with vim.g.grug_far = { ... }
		---@type grug.far.OptionsOverride
		local options = {}

		---@module "grug-far"
		require("grug-far").setup(options)
	end,
}
