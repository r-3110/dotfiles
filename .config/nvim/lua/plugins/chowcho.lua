-- @see https://github.com/tkmpypy/chowcho.nvim

---@type LazyPluginSpec
return {
	"tkmpypy/chowcho.nvim",
	config = function()
		---@module "chowcho"
		local chowcho = require("chowcho")
		chowcho.setup({})

		--[[
			2ウインドウなら<C-w><C-w>、3ウインドウ以上ならchowchoを起動する
		]]
		local win_keymap_set = function(key, callback)
			vim.keymap.set({ "n", "t" }, "<C-w>" .. key, callback)
			vim.keymap.set({ "n", "t" }, "<C-w><C-" .. key .. ">", callback)
		end

		win_keymap_set("w", function()
			local wins = 0

			-- 全ウィンドウをループ
			for i = 1, vim.fn.winnr("$") do
				local win_id = vim.fn.win_getid(i)
				local conf = vim.api.nvim_win_get_config(win_id)

				-- focusableなウィンドウをカウント
				if conf.focusable then
					wins = wins + 1

					-- ウィンドウ数が3以上ならchowchoを起動
					if wins > 2 then
						chowcho.run()
						return
					end
				end
			end

			-- ウィンドウが少なければ標準の<C-w><C-w>を実行
			vim.api.nvim_command("wincmd w")
		end)
	end,
}
