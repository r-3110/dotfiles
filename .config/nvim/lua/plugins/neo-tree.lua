-- @see https://github.com/nvim-neo-tree/neo-tree.nvim
vim.api.nvim_create_user_command("Tree", "Neotree", {})

-- [[
-- 	split関数
---@param str string
---@param sep string
local function split(str, sep)
	sep = sep or "%s" -- デフォルトで空白区切り
	local t = {}
	for s in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(t, s)
	end
	return t
end

---@type LazyPluginSpec[]
return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "MunifTanjim/nui.nvim" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		---@type neotree.Config
		opts = {
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = false, -- デフォルトで隠されているかどうか
					show_hidden_count = true,
					hide_dotfiles = false, -- dotfileを隠すかどうか
					hide_gitignored = false, -- gitignoreされているファイルを隠すかどうか
					never_show = {
						".git",
					},
				},
				window = {
					mappings = {
						["gm"] = "git_move",
					},
				},
				commands = {
					git_move = function(state)
						---@type NuiTree
						local tree = state.tree
						local node = tree:get_node()
						if not node or not node.path then
							vim.notify("ファイルが選択されていません", vim.log.levels.ERROR)
							return
						end

						local source_path = node.path
						local split_path = split(source_path, "/")
						local navPrpmot = string.format(
							"移動先のパスを入力(%s -> ?): ",
							vim.fn.shellescape(split_path[#split_path])
						)
						vim.ui.input({ prompt = navPrpmot, default = source_path }, function(destination_path)
							if not destination_path or destination_path == "" then
								vim.notify("移動先が指定されていません", vim.log.levels.ERROR)
								return
							end

							-- git mv 実行
							local cmd = string.format(
								"git mv %s %s",
								vim.fn.shellescape(source_path),
								vim.fn.shellescape(destination_path)
							)
							local result = vim.fn.system(cmd)

							if vim.v.shell_error ~= 0 then
								vim.notify("git mv に失敗しました: " .. result, vim.log.levels.ERROR)
							else
								vim.notify(
									"ファイルを移動しました: " .. source_path .. " -> " .. destination_path
								)
								-- Neo-tree UI をリフレッシュ
								require("neo-tree.sources.manager").refresh("filesystem")
							end
						end)
					end,
				},
			},
		},
	},
}
