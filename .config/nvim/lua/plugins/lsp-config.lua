-- @see https://github.com/mfussenegger/nvim-lint
-- @see https://github.com/williamboman/mason.nvim

return {
	{
		"mfussenegger/nvim-lint",
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			---@types table<string, string[]>
			local linters = {
				fish = { "fish" },
				zsh = { "zsh" },
				yaml = { "yamllint" },
				markdown = { "markdownlint-cli2" },
				json = { "jsonlint" },
				cfn = { "cfn_lint" },
				["yaml.ghaction"] = { "actionlint" },
				["yaml.cfn"] = { "yamllint", "cfn_lint" },
				dotenv = { "dotenv_linter" },
				dockerfile = { "hadolint" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				lua = { "luacheck" },
				python = { "ruff" },
			}

			-- Set up linters
			lint.linters_by_ft = linters

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
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
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamlls = {
					filetypes = { "yaml", "yml" },
					settings = {
						yaml = {
							customTags = {
								"!And",
								"!And sequence",
								"!If",
								"!If sequence",
								"!Not",
								"!Not sequence",
								"!Equals",
								"!Equals sequence",
								"!Or",
								"!Or sequence",
								"!FindInMap",
								"!FindInMap sequence",
								"!Base64",
								"!Join",
								"!Join sequence",
								"!Cidr",
								"!Ref",
								"!Sub",
								"!Sub sequence",
								"!GetAtt",
								"!GetAZs",
								"!ImportValue",
								"!ImportValue sequence",
								"!Select",
								"!Select sequence",
								"!Split",
								"!Split sequence",
							},
						},
					},
				},
			},
		},
	},
	-- add any tools you want to have installed below
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"hadolint",
				"phpcs",
				"php-cs-fixer",
			},
		},
	},
}
