-- @see https://github.com/mfussenegger/nvim-lint
-- @see https://github.com/neovim/nvim-lspconfig
-- @see https://github.com/williamboman/mason.nvim

vim.lsp.enable({ "pyright" })

-- vtslsの再起動コマンド monorepoだと最初にアタッチされたtsconfigを参照し続けるため
vim.keymap.set("n", "<leader>tr", ":LspRestart vtsls<CR>", { desc = "vtsls Restart" })

---@type LazyPluginSpec[]
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
				typescript = { "eslint" },
				javascript = { "eslint" },
				typescriptreact = { "eslint" },
				lua = { "luacheck" },
				python = { "ruff" },
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
		dependencies = {
			{ "mason-org/mason-lspconfig.nvim", version = "^2.0.0" },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{
							path = {
								"lua",
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
								"/Users/ryo/.local/share/mise/installs/neovim/",
								"/Users/ryo/.local/share/nvim/",
								"/home/ryo/.local/share/mise/installs/neovim/",
								"/home/ryo/.local/share/nvim/",
							},
							words = { "vim%.uv" },
						},
					},
				},
			},
		},
		opts = {
			servers = {
				--- typescript-toolsを使用するため無効に
				tsserver = {
					enabled = false,
				},
				ts_ls = {
					enabled = false,
				},
				vtsls = {
					enabled = true,
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
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"cfn-lint",
				"ruff",
				"actionlint",
				"biome",
				"docker-compose-language-service",
				"dockerfile-language-server",
				"dotenv-linter",
				"eslint-lsp",
				"flake8",
				"hadolint",
				"html-lsp",
				"json-lsp",
				"jsonlint",
				"jsonnet-language-server",
				"lua-language-server",
				"luacheck",
				"markdown-toc",
				"markdownlint-cli2",
				"marksman",
				"php-cs-fixer",
				"phpactor",
				"phpcs",
				"prettier",
				"pyright",
				"shellcheck",
				"shfmt",
				"sqlfluff",
				"stylua",
				"taplo",
				"tsp-server",
				"vtsls",
				"vacuum",
				"vale",
				"yaml-language-server",
				"yamllint",
			},
		},
	},
	-- {
	--
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	ft = { "typescript", "typescriptreact", "typescript.tsx" },
	-- 	---@type Settings
	-- 	--- @diagnostic disable-next-line: missing-fields
	-- 	opts = {},
	-- },
}
