-- @see https://github.com/nvim-telescope/telescope.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"nvim-telescope/telescope.nvim",
		-- branch = "master",
		version = "^0.2.x",
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
			{
				"nvim-telescope/telescope-frecency.nvim",
			},
			{
				"fdschmidt93/telescope-egrepify.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			-- add a keymap to browse plugin files
			-- Buffers
			{
				"<leader>fb",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fB",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").buffers({
						show_all_buffers = true,
						sort_mru = true,
					})
				end,
				desc = "Buffers (all)",
			},
			-- Config files
			{
				"<leader>fc",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").find_files({
						cwd = vim.fn.stdpath("config"),
					})
				end,
				desc = "Find Config File",
			},
			-- Files
			{
				"<leader>fC",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").find_files({
						cwd = require("lazyvim.util").root(),
					})
				end,
				desc = "Find Files (Root Dir)",
			},
			{
				"<leader>ff",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").find_files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fF",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").find_files({
						cwd = vim.fn.expand("%:p:h"),
					})
				end,
				desc = "Find Files in current buffer directory",
			},
			{
				"<leader>fg",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").git_files()
				end,
				desc = "Find Files (git-files)",
			},
			{
				"<leader>gs",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").git_status()
				end,
				desc = "Git Modified Files",
			},
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
			{
				"<leader>fo",
				function()
					---@module "telescope.builtin"
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Find Current Buffer",
			},
		},
		config = function()
			---@module "telescope"
			local telescope = require("telescope")
			---@module "telescope.actions.state"
			local action_state = require("telescope.actions.state")
			---@module "telescope-live-grep-args.actions"
			local lga_actions = require("telescope-live-grep-args.actions")

			---@class SmartQuoteOpts
			---@field postfix? string オプションとして追加する文字列 (例: " --iglob ")

			---クォート済みか判定し、適切に postfix を追加する高階関数
			---@param opts? SmartQuoteOpts オプション設定
			---@return fun(prompt_bufnr: integer): nil Telescopeのマッピング用関数
			local smart_quote_prompt = function(opts)
				opts = opts or {}
				local postfix = opts.postfix or ""
				local postfix_trimmed = vim.trim(postfix)

				-- telescope のマッピングが実行する実際の関数を返す
				return function(prompt_bufnr)
					local current_picker = action_state.get_current_picker(prompt_bufnr)
					local prompt = current_picker:_get_prompt()
					local trimmed_prompt = vim.trim(prompt)
					local is_quoted_head = trimmed_prompt:match('^"[^"]*"') ~= nil

					local append_postfix = function(base)
						if postfix_trimmed == "" then
							return base
						end
						if base:find(postfix_trimmed, 1, true) then
							return base
						end
						return base .. " " .. postfix_trimmed
					end

					-- 先頭の検索語がダブルクォート済みなら、クォートを重ねずにオプションだけ追加
					if is_quoted_head then
						local new_prompt = append_postfix(trimmed_prompt)
						current_picker:set_prompt(new_prompt)
					else
						-- クォートされていない場合は、通常の元の挙動（クォートしてpostfix追加）
						lga_actions.quote_prompt(opts)(prompt_bufnr)
					end
				end
			end

			telescope.setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = { prompt_position = "bottom", vertical = { width = 0.9 }, preview_cutoff = 0 },
					sorting_strategy = "descending",
					path_display = {
						filename_first = {
							reverse_directories = true,
						},
					},
					file_ignore_patterns = { "%.git/" },
					winblend = 0,
				},
				pickers = {
					buffers = {
						sort_mru = true,
					},
					find_files = {
						hidden = true,
					},
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = smart_quote_prompt({ postfix = " --iglob " }),
								["<C-g>"] = smart_quote_prompt({ postfix = " --no-ignore" }),
								["<C-a>"] = smart_quote_prompt({ postfix = " --hidden" }),
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
					---@module "telescope._extensions.egrepify"
					egrepify = {
						permutations = true,
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
			telescope.load_extension("frecency")
			telescope.load_extension("egrepify")
			telescope.load_extension("file_browser")
		end,
	},
}
