--@see https://github.com/stevearc/oil.nvim

---@type LazyPluginSpec[]
return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		---@module "oil"
		---@type oil.SetupOpts
		opts = {
			git = {
				-- Return true to automatically git add/mv/rm files
				add = function()
					return false
				end,
				mv = function()
					return true
				end,
				rm = function()
					return false
				end,
			},
		},
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	},
}
