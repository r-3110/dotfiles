-- @see https://github.com/folke/snacks.nvim

---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	init = function()
		local function set_indent_highlights()
			vim.api.nvim_set_hl(0, "SnacksIndentChunkCustom", { fg = "#7aa2f7" })
		end

		set_indent_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_indent_highlights,
		})
	end,
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
		{
			"<leader>e",
			function()
				---@module "snacks"
				require("snacks").explorer()
			end,
			desc = "Toggle Snacks Explorer",
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
		explorer = {
			enabled = true,
		},
		picker = {
			sources = {
				explorer = {
					hidden = true,
				},
			},
		},
		indent = {
			enabled = true,
			chunk = {
				enabled = true,
				hl = "SnacksIndentChunkCustom",
			},
		},
	},
}
