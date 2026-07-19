--@see https://github.com/maelwalser/speed-motion.nvim
--@see https://github.com/uswebk/vimro.nvim

---@type LazySpec[]
return {
	{
		"seandewar/nvimesweeper",
		cmd = "Nvimesweeper",
	},
	{
		"maelwalser/speed-motion.nvim",
		cmd = "SpeedMotion", -- Lazy load when the command is used
	},
	{
		"uswebk/vimro.nvim",
		cmd = "Vimro",
		opts = {},
	},
}
