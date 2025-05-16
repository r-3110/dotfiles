-- @see https://github.com/VonHeikemen/fine-cmdline.nvim

return {
	---@type LazyPluginSpec
	{ "Shougo/ddc.vim" },
	---@type LazyPluginSpec
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
		},
	},
}
