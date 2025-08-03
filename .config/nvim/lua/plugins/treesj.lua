-- @see https://github.com/Wansmer/treesj

---@type LazyPluginSpec
return {
	"Wansmer/treesj",
	event = "VeryLazy",
	lazy = true,
	keys = { "<space>m", "<space>j", "<space>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	config = function()
		require("treesj").setup({ --[[ your config ]]
		})
	end,
}
