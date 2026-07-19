--@see https://github.com/NicolasGB/jj.nvim
--@see https://github.com/larpios/jj-conflict.nvim
--@see https://github.com/MrDwarf7/lazyjui.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"nicolasgb/jj.nvim",
		version = "*", -- Use latest stable release
		-- Or from the main branch (uncomment the branch line and comment the version line)
		-- branch = "main",
		event = "VeryLazy",
		config = function()
			---@module "jj"
			require("jj").setup({})
		end,
	},
	{
		"larpios/jj-conflict.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = {
			"JjConflictList",
			"JjConflictChooseBoth",
			"JjConflictChooseNone",
			"JjConflictChooseOurs",
			"JjConflictChooseTheirs",
			"JjConflictNextConflict",
			"JjConflictPrevConflict",
			"JjConflictSquash",
			"JjConflictResolve",
			"JjConflictLog",
			"JjConflictStatus",
			"JjConflictDiff",
		},
		config = true,
	},
	{
		"mrdwarf7/lazyjui.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<Leader>gj",
				function()
					---@module "lazyjui"
					require("lazyjui").open()
				end,
				desc = "Open jjui",
			},
		},
		---@type lazyjui.Opts
		opts = {},
	},
}
