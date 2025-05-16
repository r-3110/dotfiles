-- @see https://github.com/rgroli/other.nvim

---@type LazyPluginSpec
return {
	"rgroli/other.nvim",
	lazy = true,
	event = "BufReadPre",
	config = function()
		require("other-nvim").setup({
			mappings = {
				"livewire",
				"angular",
				"laravel",
				"rails",
				"golang",
				"python",
				"react",
				"rust",
			},
		})
	end,
}
