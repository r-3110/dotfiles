-- @see https://github.com/nvim-telescope/telescope.nvim

---@type LazyPluginSpec[]
return {
	-- change some telescope options and a keymap to browse plugin files
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "tsakirist/telescope-lazy.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
			{
				"<leader>fl",
				function()
          require("telescope").extensions.live_grep_args.live_grep_args()
				end,
				desc = "Live Grep",
			},
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
					},
				},
			},
			extensions = {
				---@module "telescope._extensions.lazy"
				---@type TelescopeLazy.Config
				lazy = {},
			},
		},
		config = function()
			local telescope = require("telescope")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								-- freeze the current list and start a fuzzy search in the frozen list
								["<C-space>"] = lga_actions.to_fuzzy_refine,
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
				},
			})

			telescope.load_extension("lazy")
			telescope.load_extension("live_grep_args")
		end,
	},
}
