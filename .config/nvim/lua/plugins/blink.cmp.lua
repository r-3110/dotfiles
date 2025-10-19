--@see https://cmp.saghen.dev/
--@see https://github.com/Kaiser-Yang/blink-cmp-avante

---@type LazyPluginSpec
return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"alexandre-abrioux/blink-cmp-npm.nvim",
		"junkblocker/blink-cmp-wezterm",
		"moyiz/blink-emoji.nvim",
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				---@module "luasnip.loaders.from_vscode"
				require("luasnip.loaders.from_vscode").lazy_load()
				---@module "luasnip.loaders.from_lua"
				require("luasnip.loaders.from_lua").load({ paths = { "~/dotfiles/.config/nvim/snippet" } })
			end,
		},
		-- ... Other dependencies
	},
	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		sources = {
			-- Add 'avante' to the list
			default = { "avante", "npm", "wezterm", "lazydev", "emoji", "lsp", "path", "buffer" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				npm = {
					name = "npm",
					module = "blink-cmp-npm",
					async = true,
					-- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
					score_offset = 100,
					-- optional - blink-cmp-npm config
					---@module "blink-cmp-npm"
					---@type blink-cmp-npm.Options
					--- @diagnostic disable-next-line: missing-fields
					opts = {
						ignore = {},
						only_semantic_versions = true,
						only_latest_version = false,
					},
				},
				wezterm = {
					module = "blink-cmp-wezterm",
					name = "wezterm",
					-- default options
					opts = {
						all_panes = false,
						capture_history = false,
						-- only suggest completions from `wezterm` if the `trigger_chars` are
						-- used
						triggered_only = false,
						trigger_chars = { "." },
					},
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15, -- Tune by preference
					opts = {
						insert = true, -- Insert emoji (default) or complete its name
						---@type string|table|fun():table
						trigger = function()
							return { ":" }
						end,
					},
					should_show_items = function()
						return vim.tbl_contains(
							-- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
							{ "gitcommit", "markdown" },
							vim.o.filetype
						)
					end,
				},
			},
		},
		snippets = {
			preset = "luasnip",
		},
	},
}
