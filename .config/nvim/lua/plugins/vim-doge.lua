-- @see https://github.com/kkoomen/vim-doge

---@module "lazy"
---@type LazyPluginSpec
return {
	"kkoomen/vim-doge",
	ft = {
		"c",
		"cpp",
		"cs",
		"groovy",
		"html",
		"java",
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"javascript.tsx",
		"lua",
		"php",
		"python",
		"r",
		"ruby",
		"rust",
		"scala",
		"sh",
		"svelte",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	init = function()
		vim.g.doge_mapping = "<leader>dg"
	end,
}

-- Interactive mode comment todo-jumping
-- vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
-- vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
-- vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)")
-- vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
