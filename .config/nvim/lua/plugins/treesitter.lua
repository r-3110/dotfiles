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
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					local tree_sitter_parsers = require("nvim-treesitter.parsers")

					---@type ParserInfo
					---@diagnostic disable-next-line: missing-fields
					local gh_actions_expressions = {
						---@diagnostic disable-next-line: missing-fields
						install_info = {
							url = "https://github.com/Hdoc1509/tree-sitter-gh-actions-expressions",
							revision = "ad64d630d386894e57b836d9f0c1d1d948a3a8cc",
							branch = "release",
							-- location = "src/parser.c",
							-- generate = false,
							-- generate_from_json = false,
							-- queries = "queries/neovim",
						},
					}

					tree_sitter_parsers.ghaction = gh_actions_expressions
				end,
			})

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
				"ghaction",
			}

			---@type InstallOptions
			local options = {}

			treesitter.install(languages, options)
		end,
	},
}
