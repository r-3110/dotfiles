--@see https://cmp.saghen.dev/
--@see https://github.com/Kaiser-Yang/blink-cmp-avante

---@type LazyPluginSpec
return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
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
			default = { "avante", "lsp", "path", "buffer" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
			},
		},
		snippets = {
			preset = "luasnip",
		},
	},
}
