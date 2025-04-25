-- @see https://github.com/eetann/senpai.nvim

return {
	"eetann/senpai.nvim",
	build = "bun install",
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
