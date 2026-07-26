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
		"rainbowhxch/accelerated-jk.nvim",
		vscode = false,
	},
	{
		"folke/flash.nvim",
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
