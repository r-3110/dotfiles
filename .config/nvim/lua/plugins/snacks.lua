-- @see https://github.com/folke/snacks.nvim

---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
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
	},
}
