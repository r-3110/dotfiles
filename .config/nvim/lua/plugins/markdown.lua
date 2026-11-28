-- @see https://github.com/mattn/vim-maketable
-- @see https://github.com/delphinus/md-render.nvim

---@type LazyPluginSpec[]
return {
	{
		"mattn/vim-maketable",
		ft = { "markdown" },
	},
	{
		"delphinus/md-render.nvim",
		version = "*",
		cmd = "MdRender",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "delphinus/budoux.lua", version = "*" },
		},
		keys = {
			{ "<leader>mp", "<Plug>(md-render-preview)", desc = "Markdown preview (toggle)" },
			{ "<leader>mt", "<Plug>(md-render-preview-tab)", desc = "Markdown preview in tab (toggle)" },
		},
	},
}
