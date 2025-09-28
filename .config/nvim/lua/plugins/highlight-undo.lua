--@see https://github.com/tzachar/highlight-undo.nvim

---@type LazyPluginSpec
return {
	"tzachar/highlight-undo.nvim",
	event = "BufReadPost",
	opts = {
		duration = 300,
		pattern = { "*" },
		ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
		-- ignore_cb is in comma as there is a default implementation. Setting
		-- to nil will mean no default os called.
		-- ignore_cb = nil,
	},
}
