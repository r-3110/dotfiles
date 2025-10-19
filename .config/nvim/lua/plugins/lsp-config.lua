-- @see https://github.com/mfussenegger/nvim-lint
-- @see https://github.com/neovim/nvim-lspconfig
-- @see https://github.com/mason-org/mason.nvim
-- @see https://github.com/bassamsdata/namu.nvim
-- @see https://github.com/dnlhc/glance.nvim

vim.lsp.enable({ "pyright" })

-- vtslsの再起動コマンド monorepoだと最初にアタッチされたtsconfigを参照し続けるため
vim.keymap.set("n", "<leader>tr", ":LspRestart vtsls<CR>", { desc = "vtsls Restart" })

---@type LazyPluginSpec[]
return {
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
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason-lspconfig.nvim", version = "^2.0.0" },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				dependencies = {
					{ "DrKJeff16/wezterm-types", lazy = true },
				},
				---@module "lazydev"
				---@type lazydev.Config
				opts = {
					debug = false,
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{
							path = {
								"${3rd}/luv/library",
							},
							words = { "vim%.uv" },
						},
						"lazy.nvim",
						"LazyVim",
						{ path = "LazyVim", words = { "LazyVim" } },
						{ path = "wezterm-types", mods = { "wezterm" } },
					},
					-- luarc.jsonによるlibraryの読み込みだとlsp attach時に読み込みが巨大になってしまう。
					-- nvimではlazyvimで必要な時に必要なファイルだけ読むように。
					-- vscodeではあまり編集しないので妥協として.settings.jsonで有効化することで対応している。
					---@type boolean|(fun(root:string):boolean?)
					enabled = true,
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
				"stylelint",
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
	{
		"bassamsdata/namu.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {
			global = {},
			namu_symbols = { -- Specific Module options
				options = {},
			},
		},
	},
	{
		"dnlhc/glance.nvim",
		event = "VeryLazy",
		lazy = true,
		cmd = "Glance",
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
