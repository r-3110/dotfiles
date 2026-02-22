-- @see https://github.com/mason-org/mason.nvim
-- @see https://github.com/esmuellert/nvim-eslint
-- @see https://github.com/bassamsdata/namu.nvim
-- @see https://github.com/dnlhc/glance.nvim

local file_types = require("utils.filetype")

-- vtslsの再起動コマンド monorepoだと最初にアタッチされたtsconfigを参照し続けるため
vim.keymap.set("n", "<leader>tr", ":LspRestart vtsls<CR>", { desc = "vtsls Restart" })

---@type LazyPluginSpec[]
return {
	-- lspconfigはマニュアルで設定するため、lazyvimのlspは無効化する。
	{ "lazyvim.plugins.lsp", enabled = false },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
				---@module "mason"
				---@type MasonSettings
				opts = {},
			},
			{
				"neovim/nvim-lspconfig",
				dependencies = {
					"b0o/SchemaStore.nvim",
					lazy = true,
					version = false,
				},
				---@module "lspconfig"
				---@param opts PluginLspOpts
				opts = function(_, opts)
					---dartls
					vim.lsp.config.dartls = {
						cmd = { "dart", "language-server", "--protocol=lsp" },
						filetypes = { "dart" },
					}

					vim.lsp.config.nixd = {
						cmd = { "nixd" },
						filetypes = { "nix" },
					}

					vim.lsp.config.jsonls = {
						-- lazy-load schemastore when needed
						before_init = function(_, new_config)
							---@diagnostic disable-next-line: inject-field
							new_config.settings.json.schemas = new_config.settings.json.schemas or {}
							---@module "schemastore"
							vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
						end,
						settings = {
							json = {
								format = {
									enable = true,
								},
								validate = { enable = true },
							},
						},
					}

					local root_pattern = require("lspconfig.util").root_pattern

					vim.lsp.config.denols = {
						mason = false,
						root_dir = function(bufnr, on_dir)
							local fname = vim.api.nvim_buf_get_name(bufnr)
							local filepath = root_pattern("deno.json", "deno.jsonc")(fname)

							if filepath == nil then
								return
							end

							on_dir(root_pattern("deno.json", "deno.jsonc")(fname))
						end,
						-- root_markers = { "deno.json", "deno.jsonc" },
					}

					vim.lsp.config.vtsls = {
						mason = false,
						root_dir = function(bufnr, on_dir)
							local fname = vim.api.nvim_buf_get_name(bufnr)

							local deno_filepath = root_pattern("deno.json", "deno.jsonc")(fname)

							-- deno.jsonがある場合は起動しない
							if deno_filepath ~= nil then
								return
							end

							on_dir(root_pattern("tsconfig.json", "package.json")(fname))
						end,
						-- root_markers = { "tsconfig.json", "package.json" },
					}

					vim.lsp.config.yamlls = {
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
					}

					vim.lsp.config.gh_actions_ls = {
						filetypes = { file_types.my_filetypes.gh },
					}

					vim.lsp.enable({
						"dartls",
						"nixd",
						"jsonls",
						"denols",
						"vtsls",
						"yamlls",
						"gh_actions_ls",
					})

					return opts
				end,
			},
		},
		---@module "mason-lspconfig"
		---@type MasonLspconfigSettings
		opts = {
			automatic_enable = true,
			ensure_installed = {
				"bashls",
				"copilot",
				"denols",
				"docker_compose_language_service",
				"dockerls",
				"eslint",
				"gh_actions_ls",
				"gopls",
				"html",
				"jsonls",
				"jsonnet_ls",
				"lua_ls",
				"marksman",
				"oxfmt",
				"phpactor",
				"pyright",
				"ruff",
				"stylua",
				"taplo",
				"tsp_server",
				"vtsls",
				"yamlls",
			},
		},
	},
	{
		"esmuellert/nvim-eslint",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		config = function()
			require("nvim-eslint").setup({})
		end,
	},
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
