--@see https://cmp.saghen.dev/
--@see https://github.com/Kaiser-Yang/blink-cmp-avante

---@type LazyPluginSpec
return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"alexandre-abrioux/blink-cmp-npm.nvim",
		"junkblocker/blink-cmp-wezterm",
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").load({ paths = { "~/dotfiles/.config/nvim/snippet" } })
			end,
		},
		-- ... Other dependencies
	},
	---@type blink.cmp.Config
	opts = {
		sources = {
			-- Add 'avante' to the list
			default = { "avante", "npm", "wezterm", "lazydev", "lsp", "path", "buffer" },
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
			},
		},
		snippets = {
			preset = "luasnip",
		},
	},
}
