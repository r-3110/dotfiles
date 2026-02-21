--@see https://github.com/Goose97/timber.nvim

---@type LazyPluginSpec
return {
	"Goose97/timber.nvim",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		---@module "timber"
		---@type Timber.InitConfig
		require("timber").setup()
	end,
}
