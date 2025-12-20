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
	print("This is not vscode")
	-- accelerated_jk keymaps
	vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
	vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
end

-- lazydocker keymaps
vim.keymap.set("n", "<leader>k", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker", noremap = true, silent = true })

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

-- tataku-translate keymaps
vim.keymap.set(
	"n",
	"<leader>tt",
	":call tataku#call_recipe('translate')<CR>",
	{ desc = "en => ja", noremap = true, silent = true }
)
vim.keymap.set(
	"v",
	"<leader>tt",
	":call tataku#call_recipe('translate_v_range')<CR>",
	{ desc = "en => ja", noremap = true, silent = true }
)

-- skkeleton keymaps
vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-enable)]], { noremap = false })

-- venv-selector keymaps
vim.keymap.set("n", "<Leader>ve", ":VenvSelect<CR>", { desc = "Open VenvSelect", noremap = true, silent = true })

-- vim-doge keymaps
vim.keymap.set("n", "<Leader>dog", ":DogeGenerate<CR>")

-- Interactive mode comment todo-jumping
-- vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
-- vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
-- vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")

-- notion keymaps
vim.keymap.set("n", "<leader>no", function()
	require("notion").openMenu()
end, { desc = "Open Notion Menu" })
