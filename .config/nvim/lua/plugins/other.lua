-- @see https://github.com/rgroli/other.nvim

return {
	"rgroli/other.nvim",
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
