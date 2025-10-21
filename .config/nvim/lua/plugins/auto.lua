--@see https://github.com/jaswdr/nvim-auto-save

---@type LazyPluginSpec[]
return {
	{
		"jaswdr/nvim-auto-save",
		event = { "FocusLost", "BufLeave" },
		config = function()
			---@diagnostic disable-next-line: undefined-global
			AutoSaveSetup({
				enabled = true,
				notify = true,
			})
		end,
	},
}
