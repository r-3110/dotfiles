-- troubleのバッファが見切れてしまう問題の対処
-- 現状trouble bufferにフォーカスしたときにwrapする方法しかわからない
vim.api.nvim_create_autocmd("FileType", {
	pattern = "trouble",
	callback = function()
		vim.defer_fn(function()
			vim.opt_local.wrap = true
			vim.opt_local.linebreak = true
		end, 50) -- 50ms 後に実行
	end,
})
