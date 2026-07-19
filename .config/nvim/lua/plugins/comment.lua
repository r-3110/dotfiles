-- @see https://github.com/numToStr/Comment.nvim
-- @see https://github.com/JoosepAlviste/nvim-ts-context-commentstring

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function()
					---@module "ts_context_commentstring"
					require("ts_context_commentstring").setup({
						enable_autocmd = false,
					})
				end,
			},
		},
		event = "BufRead",
		config = function(_, opts)
			local ts_context_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

			---@module "Comment"
			require("Comment").setup(vim.tbl_deep_extend("force", opts, {
				pre_hook = function(ctx)
					if vim.bo.filetype == "env" then
						return "#%s"
					end
					return ts_context_pre_hook(ctx)
				end,
			}))
		end,
	},
}
