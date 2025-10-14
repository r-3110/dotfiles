-- @see https://github.com/folke/trouble.nvim
-- @see https://github.com/rachartier/tiny-inline-diagnostic.nvim

---@type LazyPluginSpec[]
return {
	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		---@type trouble.Config
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			---@type PluginConfig
			---@diagnostic disable-next-line: missing-fields
			local config = {}

			require("tiny-inline-diagnostic").setup(config)
			vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
		end,
	},
}
