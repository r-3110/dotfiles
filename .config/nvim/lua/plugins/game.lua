--@see https://github.com/maelwalser/speed-motion.nvim

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
}
