-- @see https://github.com/vim-skk/skkeleton

local default_dictionary
if vim.fn.has("mac") == 1 then
	default_dictionary = "~/Library/Application Support/AquaSKK/SKK-JISYO.L"
elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
	default_dictionary = "/mnt/c/Users/Ryo/SKK-JISYO.L"
end

---@type LazyPluginSpec
return {
	"vim-skk/skkeleton",
	dependencies = {
		{ "vim-denops/denops.vim" },
		{
			"Shougo/ddc.vim",
			dependencies = {
				"Shougo/ddc-ui-native",
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

				vim.fn["ddc#custom#patch_global"]("ui", "native")

				vim.fn["ddc#enable"]()
			end,
		},
	},
	vscode = false,
	-- event = "VeryLazy",
	config = function()
		vim.fn["skkeleton#config"]({
			globalDictionaries = { default_dictionary },
			-- globalDictionaries = { "~/SKK-JISYO.L" },
			eggLikeNewline = true,
			-- completionRankFile = "~/.skk/rank.json",
			debug = true,
		})
	end,
}
