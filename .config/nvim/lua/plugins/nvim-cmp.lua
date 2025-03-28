-- @see https://github.com/hrsh7th/nvim-cmp

return {
	-- override nvim-cmp and add cmp-emoji
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts blink.cmp.Config
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
}
