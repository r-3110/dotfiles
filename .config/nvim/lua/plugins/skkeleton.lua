-- @see https://github.com/vim-skk/skkeleton

---@type LazyPluginSpec
return {
	"vim-skk/skkeleton",
	dependencies = {
		{ "vim-denops/denops.vim" },
		{ "Shougo/ddc.vim" },
	},
	vscode = false,
	-- event = "VeryLazy",
	config = function()
		vim.fn["skkeleton#config"]({
			globalDictionaries = { "~/Library/Application Support/AquaSKK/SKK-JISYO.L" },
			-- globalDictionaries = { "~/SKK-JISYO.L" },
			eggLikeNewline = true,
			debug = true,
		})
		-- vim.fn["ddc#custom#patch_global"]("ui", "native")
		-- vim.fn["ddc#custom#patch_global"]("sources", { "skkeleton" })
		-- vim.fn["ddc#custom#patch_global"]({
		-- 	sourceOptions = {
		-- 		["skkeleton"] = {
		-- 			mark = "skkeleton",
		-- 			matchers = {},
		-- 			sorters = {},
		-- 			converters = {},
		-- 			isVolatile = true,
		-- 			minAutoCompleteLength = 1,
		-- 		},
		-- 	},
		-- })
		vim.fn["ddc#enable"]()
	end,
}
