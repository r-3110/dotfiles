-- @see https://github.com/mason-org/mason.nvim
-- @see https://github.com/esmuellert/nvim-eslint
-- @see https://github.com/bassamsdata/namu.nvim
-- @see https://github.com/dnlhc/glance.nvim
-- @see https://github.com/atusy/kakehashi
-- @see https://github.com/r4ppz/lspeek.nvim

---@module "lazy"
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
					vim.lsp.config("*", {
						---@module "blink-cmp"
						capabilities = require("blink.cmp").get_lsp_capabilities(),
					})

					vim.lsp.enable({
						"dartls",
						"nixd",
						"jsonls",
						"denols",
						"vtsls",
						"yamlls",
						"gh_actions_ls",
						"kakehashi",
					})

					return opts
				end,
			},
		},
		---@module "mason-lspconfig"
		---@type MasonLspconfigSettings
		opts = {
			automatic_enable = {
				exclude = {
					"eslint",
				},
			},
			-- おそらく命名はsnake_case
			ensure_installed = {},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		---@module "mason-tool-installer"
		---@type MasonToolInstallerSettings
		opts = {
			ensure_installed = {
				-- Linters
				"actionlint",
				"dotenv-linter",
				"golangci-lint",
				"hadolint",
				"jsonlint",
				"markdownlint-cli2",
				"shellcheck",
				"sqlfluff",
				"stylelint",
				"vacuum",
				"vale",
				"yamllint",
				-- Formatters
				"gci",
				"markdown-toc",
				"oxfmt",
				"php-cs-fixer",
				-- "pint",
				"prettierd",
				"shfmt",
				"stylua",
				-- DAP
				"debugpy",
				"js-debug-adapter",
				-- LSPs (mason-tool-installer can also manage these by package name)
				"bash-language-server",
				"buf",
				"css-lsp",
				{ "deno", version = "v2.8.3" },
				"docker-compose-language-service",
				"dockerfile-language-server",
				"gh-actions-language-server",
				"gopls",
				"html-lsp",
				"json-lsp",
				"jsonnet-language-server",
				"kakehashi",
				"laravel-ls",
				"lua-language-server",
				"markdown-oxide",
				"phpantom_lsp",
				"pyright",
				"ruff",
				"taplo",
				"tsp-server",
				"vtsls",
				"yaml-language-server",
				-- Others
				"tree-sitter-cli",
				"mpls",
			},
			auto_update = true,
			run_on_start = true,
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
	{
		"r4ppz/lspeek.nvim",
		keys = {
			{
				"gdd",
				function()
					---@module "lspeek"
					require("lspeek").peek_definition()
				end,
				desc = "Peek Definition (lspeek)",
			},
		},
		---@type lspeek.Config
		opts = {
			window = {
				width = 70,
				height = 15,
				border = "single",
			},
			-- Limits the number of stack preview windows.
			stack_limit = 7,
			-- Preview window is read-only.
			-- To edit the file, open it in a split or a new buffer
			keymaps = {
				close = "q",
				split = "s",
				vsplit = "v",
				enter = "<CR>",
				tab = "t",
				prev = "[",
				next = "]",
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
