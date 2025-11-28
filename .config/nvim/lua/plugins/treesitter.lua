-- @see https://github.com/nvim-treesitter/nvim-treesitter

---@type LazyPluginSpec[]
return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		-- lazyvim15からmainに変更されている
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = { "Hdoc1509/gh-actions.nvim" },
		config = function()
			---@module "gh-actions.tree-sitter"
			require("gh-actions.tree-sitter").setup()

			---@module "nvim-treesitter"
			local treesitter = require("nvim-treesitter")

			---@type TSConfig
			---@diagnostic disable-next-line: missing-fields
			local ts_config = {}

			treesitter.setup(ts_config)

			---@type string[]
			local languages = {
				"dockerfile",
				"bash",
				"html",
				"css",
				"scss",
				"csv",
				"go",
				"javascript",
				"json",
				"jsonnet",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"php",
				"query",
				"sql",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
				"gitignore",
				"gh_actions_expressions",
			}

			---@type InstallOptions
			local options = {}

			treesitter.install(languages, options)
		end,
	},
}
