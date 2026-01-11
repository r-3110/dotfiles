-- @see https://github.com/folke/snacks.nvim

---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	keys = {
		{
			"<leader>.",
			function()
				---@module "snacks"
				require("snacks").scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				---@module "snacks"
				require("snacks").scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
	---@module "snacks"
	--- @type snacks.Config
	opts = {
		terminal = {
			win = {
				position = "float",
			},
		},
		lazygit = {},
		notifier = {
			enabled = false,
		},
		picker = {
			enabled = true,
			sources = {
				explorer = { hidden = true },
			},
		},
	},
}
