-- @see https://github.com/vim-skk/skkeleton

local default_dictionary
local user_dictionary
if vim.fn.has("mac") == 1 then
	default_dictionary = {
		"~/.skk/share/skk/SKK-JISYO.L",

		"~/.skk/share/skk/SKK-JISYO.jinmei",
		"~/.skk/share/skk/SKK-JISYO.fullname",
		"~/.skk/share/skk/SKK-JISYO.propernoun",

		"~/.skk/share/skk/SKK-JISYO.geo",
		"~/.skk/share/skk/SKK-JISYO.station",
		"~/.skk/share/skk/SKK-JISYO.zipcode",
		"~/.skk/share/skk/SKK-JISYO.office.zipcode",
		"~/.skk/share/skk/SKK-JISYO.okinawa",

		"~/.skk/share/skk/SKK-JISYO.law",
		"~/.skk/share/skk/SKK-JISYO.edict",
		"~/.skk/share/skk/SKK-JISYO.pinyin",
		"~/.skk/share/skk/SKK-JISYO.china_taiwan",

		"~/.skk/share/skk/SKK-JISYO.emoji",
		"~/.skk/share/skk/SKK-JISYO.mazegaki",

		"~/.skk/share/skk/SKK-JISYO.itaiji",
		"~/.skk/share/skk/SKK-JISYO.itaiji.JIS3_4",
		"~/.skk/share/skk/SKK-JISYO.JIS2",
		"~/.skk/share/skk/SKK-JISYO.JIS3_4",
		"~/.skk/share/skk/SKK-JISYO.JIS2004",
	}
	user_dictionary = "~/.skkeleton"
elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
	default_dictionary = { "/mnt/c/Users/Ryo/SKK-JISYO.L" }
	user_dictionary = "/mnt/f/mydata/google-drive-share/skk/.userdict"
end

---@type LazyPluginSpec
return {
	"vim-skk/skkeleton",
	dependencies = {
		{ "vim-denops/denops.vim" },
		{
			"Shougo/ddc.vim",
			dependencies = {
				-- "Shougo/ddc-ui-native",
				{
					"Shougo/pum.vim",
					config = function()
						vim.keymap.set({ "i", "c" }, [[<C-p>]], "<cmd>call pum#map#insert_relative(-1)<CR>")
						vim.keymap.set({ "i", "c" }, [[<C-y>]], "<cmd>call pum#map#confirm()<CR>")
						vim.keymap.set({ "i", "c" }, [[<C-e>]], "<cmd>call pum#map#cancel()<CR>")
						vim.keymap.set({ "i", "c" }, [[<PageDown>]], "<cmd>call pum#map#insert_relative_page(+1)<CR>")
						vim.keymap.set({ "i", "c" }, [[<PageUp>]], "<cmd>call pum#map#insert_relative_page(-1)<CR>")
					end,
				},
				"Shougo/ddc-ui-pum",
			},
			config = function()
				vim.fn["ddc#custom#patch_global"]("sources", { "skkeleton", "skkeleton_okuri" })
				vim.fn["ddc#custom#patch_global"]({
					sourceOptions = {
						["_"] = {
							matchers = { "matcher_head" },
							sorters = { "sorter_rank" },
						},
						["skkeleton"] = {
							mark = "skkeleton",
							matchers = {},
							sorters = {},
							converters = {},
							isVolatile = true,
							minAutoCompleteLength = 1,
						},
						["skkeleton_okuri"] = {
							mark = "SKK*",
							matchers = {},
							sorters = {},
							converters = {},
							isVolatile = true,
						},
					},
				})

				-- vim.fn["ddc#custom#patch_global"]("ui", "native")
				vim.fn["ddc#custom#patch_global"]("ui", "pum")

				vim.fn["ddc#enable"]()
			end,
		},
		{
			"NI57721/skkeleton-henkan-highlight",
			config = function()
				vim.cmd([[
          highlight SkkeletonHenkan gui=reverse term=reverse cterm=reverse
        ]])
			end,
		},
	},
	vscode = false,
	event = "VeryLazy",
	config = function()
		vim.fn["skkeleton#config"]({
			globalDictionaries = default_dictionary,
			-- globalDictionaries = { "~/SKK-JISYO.L" },
			sources = { "skk_dictionary", "google_japanese_input" },
			userDictionary = user_dictionary,
			eggLikeNewline = true,
			-- completionRankFile = "~/.skk/rank.json",
			debug = false,
		})
	end,
}
