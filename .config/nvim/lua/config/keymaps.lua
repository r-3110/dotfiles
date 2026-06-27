-- @see https://www.lazyvim.org/keymaps
-- Set leader key
vim.g.mapleader = " "

vim.api.nvim_set_keymap(
	"n",
	"<Leader>ln",
	":set relativenumber!<CR>",
	{ desc = "ライン番号トグル", noremap = true, silent = true }
)

-- vscodeでは設定が効かず、定義されていると支障が出るものを除外
if not vim.g.vscode then
	-- accelerated_jk keymaps
	vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
	vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
end

-- dial keymaps
vim.keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
	require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
	require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
	require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("v", "<C-a>", function()
	require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("v", "<C-x>", function()
	require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("v", "g<C-a>", function()
	require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("v", "g<C-x>", function()
	require("dial.map").manipulate("decrement", "gvisual")
end)

-- skkeleton keymaps
vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-enable)]], { noremap = false })
