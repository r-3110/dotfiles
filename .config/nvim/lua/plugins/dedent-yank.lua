---@module "lazy"
---@type LazyPluginSpec
return {
	dir = vim.fn.has("linux") == 1 and "/home/ryo/workspace/dedent-yank.nvim"
		or "/Users/ryo/workspace/dedent-yank.nvim",
	name = "dedent-yank.nvim",
	cmd = "DedentYank",
	keys = {
		{
			"<leader>cy",
			function()
				return require("dedent-yank").operator()
			end,
			mode = "n",
			expr = true,
			desc = "Dedentしてコピー",
		},
		{
			"<leader>cy",
			function()
				require("dedent-yank").yank_selection()
			end,
			mode = "x",
			desc = "Dedentしてコピー",
		},
	},
	opts = {
		register = "+",
		notify = true,
	},
	config = function(_, opts)
		---@module "dedent-yank"
		require("dedent-yank").setup(opts)
	end,
}
