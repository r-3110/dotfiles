--@see https://github.com/jthom233/nvim-zelda
--@see https://github.com/maelwalser/speed-motion.nvim

---@type LazySpec[]
return {
	{
		"seandewar/nvimesweeper",
		event = "VeryLazy",
		lazy = true,
	},
	{
		"maelwalser/speed-motion.nvim",
		cmd = "SpeedMotion", -- Lazy load when the command is used
	},
}
