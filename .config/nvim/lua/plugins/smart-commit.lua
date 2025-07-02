--@see https://github.com/kboshold/smart-commit.nvim

---@type LazyPluginSpec
return {
	"kboshold/smart-commit.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"CopilotC-Nvim/CopilotChat.nvim", -- Optional: Required for commit message generation
	},
	config = function()
		require("smart-commit").setup(
			---@type SmartCommitConfig
			{
				defaults = {
					auto_run = true,
					sign_column = true,
					hide_skipped = true,
				},
			}
		)
	end,
	keys = {
		{
			"<leader>sc",
			function()
				require("smart-commit").toggle()
			end,
			desc = "Toggle Smart Commit",
		},
	},
}
