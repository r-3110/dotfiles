-- @see https://github.com/Wansmer/treesj

---@type LazyPluginSpec
return {
	"Wansmer/treesj",
	keys = { "<space>m", "<space>j", "<space>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		---@module "treesj"
		require("treesj").setup({})
	end,
}
