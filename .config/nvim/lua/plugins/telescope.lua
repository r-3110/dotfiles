-- @see https://github.com/nvim-telescope/telescope.nvim

---@type LazyPluginSpec[]
return {
	{
		"nvim-telescope/telescope.nvim",
		-- branch = "master",
		version = "0.1.9",
		cmd = { "Telescope" },
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "crispgm/telescope-heading.nvim" },
			{ "paopaol/telescope-git-diffs.nvim" },
			{ "nvim-telescope/telescope-ghq.nvim" },
			{ "LinArcX/telescope-changes.nvim" },
			{ "LinArcX/telescope-env.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim" },
			{ "tsakirist/telescope-lazy.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
			{
				"nvim-telescope/telescope-project.nvim",
			},
			{
				"Allianaab2m/telescope-kensaku.nvim",
			},
		},
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
			{
				"<leader>fl",
				function()
          ---@module "telescope"
          require("telescope").extensions.live_grep_args.live_grep_args()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fp",
				function()
					---@module "telescope"
					require("telescope").extensions.project.project({})
				end,
				desc = "Projects",
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
		},
		config = function()
			---@module "telescope"
			local telescope = require("telescope")
			---@module "telescope-live-grep-args.actions"
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
								["<C-g>"] = lga_actions.quote_prompt({ postfix = " --no-ignore" }),
								["<C-a>"] = lga_actions.quote_prompt({ postfix = " --hidden" }),
								-- freeze the current list and start a fuzzy search in the frozen list
								["<C-space>"] = lga_actions.to_fuzzy_refine,
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
					project = {
						---@module "telescope._extensions.project"
						---@type BaseDirSpec
						base_dirs = {
							"~/dotfiles",
							{ "~/workspace", max_depth = 3 },
						},
					},
					---@module "telescope._extensions.lazy"
					---@type TelescopeLazy.Config
					lazy = {},
					---@module "telescope._extensions.fzf"
					fzf = {
						fuzzy = true,
					},
				},
			})

			telescope.load_extension("lazy")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("project")
			telescope.load_extension("fzf")
			telescope.load_extension("heading")
			telescope.load_extension("git_diffs")
			telescope.load_extension("ghq")
			telescope.load_extension("changes")
			telescope.load_extension("env")
			telescope.load_extension("frecency")
			telescope.load_extension("kensaku")
		end,
	},
}
