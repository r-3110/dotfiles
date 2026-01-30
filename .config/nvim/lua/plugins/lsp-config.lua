-- @see https://github.com/mason-org/mason.nvim
-- @see https://github.com/bassamsdata/namu.nvim
-- @see https://github.com/dnlhc/glance.nvim

local file_types = require("utils.filetype")

-- vtslsの再起動コマンド monorepoだと最初にアタッチされたtsconfigを参照し続けるため
vim.keymap.set("n", "<leader>tr", ":LspRestart vtsls<CR>", { desc = "vtsls Restart" })

---@type LazyPluginSpec[]
return {
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

					vim.lsp.enable({ "dartls", "nixd" })

					local root_pattern = require("lspconfig.util").root_pattern

					---@type table<string, lazyvim.lsp.Config|boolean>
					local manual_setup_lsp = {
						denols = {
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
						},
						vtsls = {
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
						},
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
						gh_actions_ls = {
							filetypes = { file_types.my_filetypes.gh },
						},
					}

					local merged_config = vim.tbl_deep_extend("force", {}, opts.servers or {}, manual_setup_lsp or {})

					-- 下記のようにlazyvimではlspの設定が自動化されているため、必要に応じてここで上書きする。
					--@see https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
					opts.servers = merged_config

					return opts
				end,
			},
		},
		config = function()
			---@module "mason-lspconfig"
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				automatic_enable = false,
				ensure_installed = {
					"bashls",
					"biome",
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
					"phpactor",
					"pyright",
					"ruff",
					"stylua",
					"taplo",
					"tsp_server",
					"vtsls",
					"yamlls",
				},
			})
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
