-- @see https://github.com/rachartier/tiny-code-action.nvim

---@type LazyPluginSpec
return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
	event = "LspAttach",
	config = function()
		require("tiny-code-action").setup()
	end,
}
