--@see https://github.com/olimorris/codecompanion.nvim

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"github/copilot.vim",
	},
	opts = {
		strategies = {
			chat = {
				adapter = "copilot",
			},
			inline = {
				adapter = "copilot",
			},
			cmd = {
				adapter = "copilot",
			},
		},
		display = {
			action_palette = {
				width = 300,
				height = 20,
				prompt = "Prompt ",
				provider = "default",
				opts = {
					show_default_actions = true,
					show_default_prompt_library = true,
				},
			},
		},
		opts = {
			log_level = "DEBUG",
			language = "Japanese",
		},
	},
}
