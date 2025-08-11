--@see https://github.com/stevearc/quicker.nvim

---@type LazyPluginSpec
return {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	---@module "quicker"
	---@type quicker.SetupOptions
	opts = {
		keys = {
			{ ">", "<cmd>lua require('quicker').expand()<CR>", desc = "Expand quickfix content" },
			{ "<", "<cmd>lua require('quicker').collapse()<CR>", desc = "Collapse quickfix content" },
		},
	},
}
