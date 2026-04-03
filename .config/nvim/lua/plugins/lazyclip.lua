-- @see https://github.com/atiladefreitas/lazyclip
-- @see https://github.com/h3pei/copy-file-path.nvim

---@module "lazyvim"
---@type LazyPluginSpec[]
return {
	{
		"atiladefreitas/lazyclip",
		config = function()
			---@module "lazyclip"
			require("lazyclip").setup({
				-- your custom config here (optional)
			})
		end,
		keys = {
			{
				"<leader>lc",
				":LazyClip<CR>",
				desc = "Open Clipboard Manager",
			},
		},
		-- Optional: Load plugin when yanking text
		event = { "TextYankPost" },
	},
	{
		"h3pei/copy-file-path.nvim",
		event = "BufRead",
	},
}
