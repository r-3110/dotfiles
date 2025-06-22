-- @see https://github.com/eetann/senpai.nvim

---@type LazyPluginSpec
return {
	"eetann/senpai.nvim",
	build = "bun install --frozen-lockfile",
	-- event = "VeryLazy",
	-- lazy = true,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"grapp-dev/nui-components.nvim",
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
