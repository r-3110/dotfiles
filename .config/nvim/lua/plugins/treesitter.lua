-- @see https://github.com/nvim-treesitter/nvim-treesitter

---@type LazyPluginSpec[]
return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"dockerfile",
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"php",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
	-- would overwrite `ensure_installed` with the new value.
	-- If you'd rather extend the default config, use the code below instead:
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"tsx",
				"typescript",
			})
		end,
	},
}
