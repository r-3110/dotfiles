-- @see https://github.com/eetann/senpai.nvim

---@type LazyPluginSpec
return {
	"eetann/senpai.nvim",
	build = "bun install",
	lazy = true,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	--- @type senpai.Config
	opts = {
		providers = {
			default = "google",
			google = { model_id = "gemini-2.0-flash-001" },
		},
	},
}
