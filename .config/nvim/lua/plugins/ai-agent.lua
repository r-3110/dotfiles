--@see https://github.com/folke/sidekick.nvim
--@see https://github.com/yetone/avante.nvim
--@see https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua
--@see https://github.com/olimorris/codecompanion.nvim

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
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = true,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		---@module "avante"
		---@type avante.Config
		--- @diagnostic disable-next-line: missing-fields
		opts = {
			---@type avante.ProviderName
			provider = "copilot",
			auto_suggestions_provider = "copilot",
			system_prompt = "すべて日本語で応答してください。",
			behaviour = {
				-- トークンかなり消費するので使用しない
				auto_suggestions = false,
			},
			---@type {[string]: AvanteProvider}
			providers = {
				---@type AvanteSupportedProvider
				copilot = {
					model = "claude-sonnet-4.6",
					-- まだavanteでは未サポート
					-- model = "gpt-5-codex",
					extra_request_body = {
						max_tokens = 4096,
						temperature = 0,
					},
				},
			},
			selector = {
				provider = "telescope",
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
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
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				---@module "render-markdown"
				---@type render.md.UserConfig
				opts = {
					file_types = { "markdown", "Avante" },
					completions = { lsp = { enabled = true } },
				},
				config = function()
					--@see https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#obsidiannvim
					local ok, obsidian = pcall(require, "obsidian")
					if ok then
						obsidian.get_client().opts.ui.enable = false
					end
				end,
				ft = { "markdown", "Avante" },
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
