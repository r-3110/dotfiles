-- @see https://github.com/folke/trouble.nvim

---@type LazyPluginSpec[]
return {
	-- change trouble config
	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},
}
