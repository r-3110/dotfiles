-- @see https://github.com/linux-cultist/venv-selector.nvim/tree/regexp

---@type LazyPluginSpec
return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		-- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	ft = { "python" },
	---@module "venv-selector"
	---@type venv-selector.Options
	opts = {
		-- Your settings go here
	},
}
