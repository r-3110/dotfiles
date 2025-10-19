--@see https://github.com/atusy/aibou.nvim

---@type LazyPluginSpec
return {
	"atusy/aibou.nvim",
	dependencies = {
		"olimorris/codecompanion.nvim",
	},
	-- lazy trueだと使えないので注意
	-- lazy = true,
	config = function()
		vim.keymap.set("n", "<leader>ai", function()
			---@module "aibou.codecompanion"
			require("aibou.codecompanion").start()
		end, { desc = "Start aibou" })
	end,
}
