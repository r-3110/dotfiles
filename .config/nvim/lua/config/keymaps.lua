-- @see https://www.lazyvim.org/keymaps
-- Set leader key
vim.g.mapleader = " "

-- vscodeでは設定が効かず、定義されていると支障が出るものを除外
if not vim.g.vscode then
	print("This is not vscode")
	-- accelerated_jk keymaps
	vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
	vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
end

-- memolist keymaps
vim.api.nvim_set_keymap("n", "<Leader>mn", ":MemoNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ml", ":MemoList<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>mg", ":MemoGrep<CR>", { noremap = true, silent = true })

-- neovim-project keymaps
vim.api.nvim_set_keymap("n", "<Leader>pjd", ":NeovimProjectDiscover<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>pjh", ":NeovimProjectHistory<CR>", { noremap = true, silent = true })

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

-- CodeCompanion keymaps
vim.keymap.set(
	"n",
	"<leader>cca",
	":CodeCompanionActions<CR>",
	{ desc = "Open CodeCompanionActions", noremap = true, silent = true }
)

-- tataku-translate keymaps
vim.keymap.set(
	"n",
	"<leader>tt",
	":call tataku#call_recipe('translate')<CR>",
	{ desc = "en => ja", noremap = true, silent = true }
)

-- skkeleton keymaps
vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-enable)]], { noremap = false })

-- senpai keymaps
vim.keymap.set("n", "<Leader>sc", ":Senpai toggleChat<CR>", { desc = "Open Senpai", noremap = true, silent = true })

-- venv-selector keymaps
vim.keymap.set("n", "<Leader>ve", ":VenvSelect<CR>", { desc = "Open VenvSelect", noremap = true, silent = true })