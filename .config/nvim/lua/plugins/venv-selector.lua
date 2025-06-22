-- @see https://github.com/linux-cultist/venv-selector.nvim/tree/regexp

---@type LazyPluginSpec
return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		-- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	event = "VeryLazy",
	lazy = false,
	branch = "regexp", -- This is the regexp branch, use this for the new version
	---@type venv-selector.Config
	opts = {
		-- Your settings go here
	},
	{ "mfussenegger/nvim-dap" },
	{ "mfussenegger/nvim-dap-python", enabled = false },
}
