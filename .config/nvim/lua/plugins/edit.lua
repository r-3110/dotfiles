--@see https://github.com/qwavies/smart-backspace.nvim
--@see https://github.com/windwp/nvim-autopairs

---@type LazyPluginSpec[]
return {
	{
		"qwavies/smart-backspace.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			silent = false,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			map_bs = false,
		},
	},
}
