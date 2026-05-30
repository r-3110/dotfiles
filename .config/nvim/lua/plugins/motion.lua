--@see https://github.com/nekowasabi/hellshake-yano.vim
--@see https://github.com/rainbowhxch/accelerated-jk.nvim
--@see https://github.com/folke/flash.nvim
--@see https://github.com/s-show/extend_word_motion.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"vim-denops/denops.vim",
		lazy = false,
	},
	{
		"nekowasabi/hellshake-yano.vim",
		dependencies = { "vim-denops/denops.vim" },
		init = function()
			vim.g.hellshake_yano = {
				enabled = true,
				debugMode = false,
				useJapanese = true,
				defaultMinWordLength = 2,
				maxHints = 400,
				japaneseMergeThreshold = 3,
				useTinySegmenter = false,
				segmenterThreshold = 6,
				enableHighlight = true,
				minWordLength = 2,
				useHintGroups = true,
				motionTimeout = 4000,
				cacheSize = 2000,
				perKeyMotionCount = {
					v = 1,
					w = 2,
					e = 2,
					b = 2,
				},
				perKeyMinLength = {
					v = 1,
					w = 4,
					e = 3,
				},
			}
		end,
	},
	{
		"rainbowhxch/accelerated-jk.nvim",
		vscode = false,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		lazy = true,
		---@type Flash.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
	{
		"s-show/extend_word_motion.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {},
		dependencies = {
			"sirasagi62/tinysegmenter.nvim",
		},
	},
}
