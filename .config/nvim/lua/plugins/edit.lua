--@see https://github.com/windwp/nvim-autopairs
--@see https://github.com/kylechui/nvim-surround

---@type LazyPluginSpec[]
return {
	{
		"nvim-mini/mini.pairs",
		enabled = false,
	},
	{
		"nvim-mini/mini.ai",
		event = function()
			return { "LazyFile" }
		end,
		opts = {
			mappings = {
				around_next = "aN",
				inside_next = "iN",
				around_last = "aL",
				inside_last = "iL",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			map_bs = true,
			check_ts = true,
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "LazyFile",
		config = function()
			---@module "nvim-surround"
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
				keymaps = {
					insert = "<C-g>s",
					insert_line = "<C-g>S",
					normal = "ys",
					normal_cur = "yss",
					normal_line = "yS",
					normal_cur_line = "ySS",
					visual = "gs",
					visual_line = "gS",
					delete = "ds",
					change = "cs",
					change_line = "cS",
				},
			})
		end,
	},
}
