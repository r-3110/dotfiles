---@type FiletypeUtils
local file_type = require("utils.filetype")

vim.filetype.add({
	extension = {
		yml = "yaml",
	},
	pattern = {
		["%.env.*"] = "dotenv",
		[file_type.my_filetype_rules[file_type.my_filetypes.gh].regex] = file_type.my_filetypes.gh,
		[file_type.my_filetype_rules[file_type.my_filetypes["docker-compose"]].regex] = file_type.my_filetypes["docker-compose"],
		[file_type.my_filetype_rules[file_type.my_filetypes.dockerfile].regex] = file_type.my_filetypes.dockerfile,
		[file_type.my_filetype_rules[file_type.my_filetypes.tsconfig].regex] = file_type.my_filetypes.tsconfig,
		[".*%.yml"] = file_type.checkCfn,
		[".*%.yaml"] = file_type.checkCfn,
	},
	filename = {
		["venv-selector.lua"] = "lua",
	},
})

--- neovide settings
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_short_animation_length = 0.04
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_cursor_vfx_mode = "railgun"

-- ヘルプファイルの言語設定
vim.o.helplang = "ja,en"

-- スペルチェックの言語設定
vim.opt.spelllang = { "en", "cjk" }
