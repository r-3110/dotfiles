--@see https://github.com/jthom233/nvim-zelda

---@type LazySpec[]
return {
	{
		"jthom233/nvim-zelda",
		cmd = { "Zelda", "ZeldaStart" },
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("nvim-zelda").setup({
				teach_mode = true, -- Show vim tips while playing
				difficulty = "normal", -- easy, normal, hard
				width = 60, -- Game window width
				height = 20, -- Game window height
			})
		end,
	},
	{
		"seandewar/nvimesweeper",
		event = "VeryLazy",
		lazy = true,
	},
}
