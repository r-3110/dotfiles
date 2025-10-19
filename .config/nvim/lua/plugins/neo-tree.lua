-- @see https://github.com/nvim-neo-tree/neo-tree.nvim
---@type FiletypeUtils
local file_type = require("utils.filetype")

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

-- [[
-- nvim-web-deviconsでのアイコン取得。
-- 事前に定義済みのvim filetypeを優先して取得する。
---@param path string ファイルパス
---@param filename string ファイル名
local get_devicons = function(web_devicons, path, filename)
	local result_filetype = nil
	for filetype, rules in pairs(file_type.my_filetype_rules) do
		if path:match(rules.regex) then
			-- print("matched: " .. filename .. " -> " .. filetype)
			result_filetype = filetype
			break
		end
	end

	if result_filetype then
		local devicon, hl = web_devicons.get_icon(result_filetype)
		return devicon, hl
	end

	local devicon, hl = web_devicons.get_icon(filename)

	return devicon, hl
end

---@type LazyPluginSpec[]
return {
	-- lazyvimではdefaultでmini.iconsが入っている。これがnvim-web-deviconsを上書きして動作してしまうため無効化する。
	{ "nvim-mini/mini.icons", enabled = false, version = false },
	{
		"nvim-tree/nvim-web-devicons",
		priority = 10000,
		config = function()
			---@module "nvim-web-devicons"
			local web_devicons = require("nvim-web-devicons")

			local icons = {}
			for filetype, rules in pairs(file_type.my_filetype_rules) do
				---@type Icon
				---@diagnostic disable-next-line: missing-fields
				local icon = {
					icon = rules.icon,
					-- cterm_color = "66",
					color = rules.color,
					name = filetype,
				}

				web_devicons.set_icon({ [filetype] = icon })
			end

			web_devicons.setup({
				override = icons,
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		---@type neotree.Config
		opts = {
			default_component_configs = {
				---@diagnostic disable-next-line: missing-fields
				icon = {
					provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
						if node.type == "file" or node.type == "terminal" then
							local success, web_devicons = pcall(require, "nvim-web-devicons")
							local name = node.type == "terminal" and "terminal" or node.name

							if success then
								local devicon, hl = get_devicons(web_devicons, node.path, name)

								icon.text = devicon or icon.text
								icon.highlight = hl or icon.highlight
							end
						end
					end,
				},
			},
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
						---@module "nui.tree"
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
