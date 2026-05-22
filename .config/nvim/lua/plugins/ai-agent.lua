--@see https://github.com/folke/sidekick.nvim
--@see https://github.com/olimorris/codecompanion.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"folke/sidekick.nvim",
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>" -- fallback to normal tab
					end
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-z>",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>zz",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>zs",
				function()
					require("sidekick.cli").select()
				end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>zd",
				function()
					require("sidekick.cli").close()
				end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>zt",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>zf",
				function()
					require("sidekick.cli").send({ msg = "{file}" })
				end,
				desc = "Send File",
			},
			{
				"<leader>zv",
				function()
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>zp",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
		},
		---@module "sidekick"
		---@type sidekick.Config
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "zellij",
					enabled = true,
				},
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		version = "*",
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
	},
}
