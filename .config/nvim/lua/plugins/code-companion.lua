--@see https://github.com/olimorris/codecompanion.nvim
--@see https://github.com/atusy/aibou.nvim

---@type LazyPluginSpec[]
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		version = "17.33.0",
		cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
		keys = {
			{ "<Leader>ccct", "<Cmd>CodeCompanionChat Toggle<CR>", mode = { "n" } },
			{ "<Leader>ccc", "<Cmd>CodeCompanionChat<CR>", mode = { "v" } },
			{ "<Leader>cca", "<Cmd>CodeCompanionActions<CR>", desc = "Open CodeCompanionActions", mode = { "n", "x" } },
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
		-- {
		-- 	"atusy/aibou.nvim",
		-- 	dependencies = {
		-- 		"olimorris/codecompanion.nvim",
		-- 	},
		-- 	enable = false,
		-- 	-- fileを開いたときでないと起動しないので注意(start画面では動かない)
		-- 	event = "VeryLazy",
		-- 	lazy = true,
		-- 	config = function()
		-- 		vim.keymap.set("n", "<leader>ai", function()
		-- 			---@module "aibou.codecompanion"
		-- 			require("aibou.codecompanion").start()
		-- 		end, { desc = "Start aibou" })
		-- 	end,
		-- },
	},
}
