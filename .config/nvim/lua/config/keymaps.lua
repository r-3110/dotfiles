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

-- memolist keymaps
vim.api.nvim_set_keymap("n", "<Leader>mn", ":MemoNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ml", ":MemoList<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>mg", ":MemoGrep<CR>", { noremap = true, silent = true })

-- neovim-project keymaps
vim.api.nvim_set_keymap(
	"n",
	"<Leader>pjd",
	":NeovimProjectDiscover<CR>",
	{ desc = "プロジェクト検索", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>pjh",
	":NeovimProjectHistory<CR>",
	{ desc = "プロジェクト履歴", noremap = true, silent = true }
)

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
vim.keymap.set("n", "<Leader>sp", ":Senpai toggleChat<CR>", { desc = "Open Senpai", noremap = true, silent = true })

-- venv-selector keymaps
vim.keymap.set("n", "<Leader>ve", ":VenvSelect<CR>", { desc = "Open VenvSelect", noremap = true, silent = true })

-- nvim-dap keymaps
vim.keymap.set("n", "<Leader>du", function()
	require("dapui").toggle()
end, { desc = "Toggle DAP UI" })

vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle DAP Breakpoint" })

-- jumpcursor keymaps
vim.keymap.set(
	"n",
	"[j",
	"<Plug>(jumpcursor-jump)",
	{ desc = "Jump to previous cursor position", noremap = false, silent = true }
)

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
