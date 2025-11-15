--@see https://github.com/stevearc/conform.nvim
--@see https://github.com/mfussenegger/nvim-lint

---@type LazyPluginSpec[]
return {
	{
		"stevearc/conform.nvim",
		---@module "conform"
		---@type conform.setupOpts
		opts = {},
	},
	{
		"mfussenegger/nvim-lint",
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			---@module "lint"
			local lint = require("lint")

			---@type table<string, string[]>
			local linters = {
				fish = { "fish" },
				zsh = { "zsh" },
				yaml = { "yamllint" },
				markdown = { "markdownlint-cli2" },
				json = { "jsonlint" },
				cfn = { "cfn_lint" },
				["yaml.ghaction"] = { "actionlint" },
				["yaml.cfn"] = { "cfn_lint" },
				dotenv = { "dotenv_linter" },
				dockerfile = { "hadolint" },
				typescript = { "eslint" },
				javascript = { "eslint" },
				typescriptreact = { "eslint" },
				lua = { "luacheck" },
				python = { "ruff" },
				sql = { "sqlfluff" },
				css = { "stylelint" },
				scss = { "stylelint" },
			}

			lint.linters.luacheck = {
				name = "luacheck",
				cmd = "luacheck",
				stdin = true,
				args = {
					"--globals",
					"vim",
					"lvim",
					"reload",
					"--",
				},
				stream = "stdout",
				ignore_exitcode = true,
				parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
					source = "luacheck",
				}),
			}

			-- Set up linters
			lint.linters_by_ft = linters

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
		opts = {
			-- LazyVim extension to easily override linter options
			-- or add custom linters.
			---@type table<string, table>
			linters = {
				-- -- Example of using selene only when a selene.toml file is present
				-- selene = {
				--   -- `condition` is another LazyVim extension that allows you to
				--   -- dynamically enable/disable linters based on the context.
				--   condition = function(ctx)
				--     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
				--   end,
				-- },
			},
		},
	},
}
