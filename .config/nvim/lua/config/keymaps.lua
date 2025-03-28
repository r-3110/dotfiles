-- @see https://www.lazyvim.org/keymaps
-- Set leader key
vim.g.mapleader = " "

-- accelerated_jk keymaps
vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})

-- memolist keymaps
vim.api.nvim_set_keymap("n", "<Leader>mn", ":MemoNew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ml", ":MemoList<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>mg", ":MemoGrep<CR>", { noremap = true, silent = true })

-- neovim-project keymaps
vim.api.nvim_set_keymap("n", "<Leader>pjd", ":NeovimProjectDiscover<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>pjh", ":NeovimProjectHistory<CR>", { noremap = true, silent = true })

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
