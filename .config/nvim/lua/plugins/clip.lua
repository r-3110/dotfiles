-- @see https://github.com/atiladefreitas/lazyclip
-- @see https://github.com/h3pei/copy-file-path.nvim
-- @see https://github.com/cajames/copy-reference.nvim
-- @see https://github.com/HakonHarnes/img-clip.nvim

---@module "lazy"
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
				function()
					vim.cmd("LazyClip")
				end,
				desc = "Open Clipboard Manager",
			},
		},
		-- Optional: Load plugin when yanking text
		event = { "TextYankPost" },
	},
	{
		"h3pei/copy-file-path.nvim",
		event = "BufRead",
		keys = {
			{
				"<leader>cfp",
				function()
					vim.cmd("CopyRelativeFilePath")
				end,
				desc = "Copy relative file path to the clipboard",
			},
		},
	},
	{
		"cajames/copy-reference.nvim",
		event = "BufRead",
		keys = {
			{
				"<leader>cfl",
				function()
					vim.cmd("CopyReference line")
				end,
				mode = { "n", "v" },
				desc = "Copy file:line reference",
			},
		},
		---@module "copy-reference"
		opts = {}, -- optional configuration
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			-- recommended settings
			default = {
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = {
					insert_mode = true,
				},
				-- required for Windows users
				use_absolute_path = true,
			},
		},
	},
}
