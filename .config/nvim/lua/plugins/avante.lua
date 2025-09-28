-- @see https://github.com/yetone/avante.nvim
-- @see https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua

---@type LazyPluginSpec
return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
	---@type avante.Config
	--- @diagnostic disable-next-line: missing-fields
	opts = {
		---@type avante.ProviderName
		provider = "copilot",
		auto_suggestions_provider = "copilot",
		behaviour = {
			-- トークンかなり消費するので使用しない
			auto_suggestions = false,
		},
		---@type {[string]: AvanteProvider}
		providers = {
			---@type AvanteSupportedProvider
			copilot = {
				model = "claude-sonnet-4",
				-- まだavanteでは未サポート
				-- model = "gpt-5-codex",
				extra_request_body = {
					max_tokens = 4096,
					temperature = 0,
				},
			},
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
		--- The below dependencies are optional,
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
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
			---@type render.md.UserConfig
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
