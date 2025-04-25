-- @see https://github.com/mfussenegger/nvim-lint
-- @see https://github.com/neovim/nvim-lspconfig
-- @see https://github.com/williamboman/mason.nvim

return {
	{
		"mfussenegger/nvim-lint",
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
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
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							workspace = {
								library = {
									"lua",
									vim.env.VIMRUNTIME,
									"${3rd}/luv/library",
									"${3rd}/busted/library",
									"/Users/ryo/.local/share/mise/installs/neovim/",
									"/Users/ryo/.local/share/nvim/",
								},
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				yamlls = {
					filetypes = { "yaml", "yml" },
					settings = {
						yaml = {
							schemas = {
								["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
							},
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
				"cfn-lint",
				"ruff",
				"actionlint",
				"biome",
				"docKerCompose-language-service docker_compose_language_service",
				"dockerfile-language-server dockerls",
				"dotEnvLinter",
				"eslint-d",
				"flake8",
				"hadolint",
				"htmLLsp html",
				"jsoNLsp jsonls",
				"jsonlint",
				"jsoNnetLanguage-server jsonnet_ls",
				"lua-language-server lua_ls",
				"luacheck",
				"markdown-toc",
				"markdownlint-cli2",
				"marksman",
				"php-CsFixer",
				"phpactor",
				"phpcs",
				"prettier",
				"pyright",
				"shellcheck",
				"shfmt",
				"sqlfluff",
				"stylua",
				"taplo",
				"tsp-server tsp_server",
				"typescript-language-server ts_ls",
				"vacuum",
				"vale",
				"yamLLanguage-server yamlls",
				"yamllint",
			},
		},
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			-- ft = { "typescript", "typescriptreact", "typescript.tsx" },
			opts = {},
		},
	},
}
