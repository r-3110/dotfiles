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

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	pattern = "/tmp/nvim_ime_buffer.txt",
	callback = function()
		vim.bo.bufhidden = "hide"
		vim.bo.swapfile = false

		local function finish_nvim_ime()
			vim.cmd("write")

			local session_file = "/tmp/nvim_ime_session.txt"
			local done_file = "/tmp/nvim_ime_done.txt"

			if vim.fn.filereadable(session_file) == 0 then
				vim.notify("nvim ime: session file not found", vim.log.levels.WARN)
				return
			end

			local session = vim.fn.readfile(session_file)[1] or ""
			vim.fn.writefile({ session }, done_file)
		end

		vim.keymap.set({ "n", "i" }, "<C-s>", function()
			finish_nvim_ime()
		end, { buffer = true, noremap = true, silent = true })

		vim.keymap.set("n", "ZZ", function()
			finish_nvim_ime()
		end, { buffer = true, noremap = true, silent = true })

		vim.cmd("startinsert")
	end,
})

vim.api.nvim_create_autocmd("FocusGained", {
	pattern = "/tmp/nvim_ime_buffer.txt",
	callback = function()
		if not vim.bo.modified then
			vim.cmd("edit!")
			vim.cmd("startinsert")
		end
	end,
})
