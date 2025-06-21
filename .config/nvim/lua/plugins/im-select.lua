-- @see https://github.com/keaising/im-select.nvim

local default_im_select
local default_command
if vim.fn.has("mac") == 1 then
	default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman"
	default_command = "macism"
elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
	default_im_select = "keyboard-us"
	default_command = "/mnt/c/Users/Ryo/bin/im-select.exe"
end

---@type LazyPluginSpec
return {
	"keaising/im-select.nvim",
	vscode = true,
	event = "VeryLazy",
	lazy = true,
	config = function()
		require("im_select").setup({
			-- IM will be set to `default_im_select` in `normal` mode
			-- For Windows/WSL, default: "1033", aka: English US Keyboard
			-- For macOS, default: "com.apple.keylayout.ABC", aka: US
			-- For Linux, default:
			--               "keyboard-us" for Fcitx5
			--               "1" for Fcitx
			--               "xkb:us::eng" for ibus
			-- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
			default_im_select = default_im_select,

			-- Can be binary's name, binary's full path, or a table, e.g. 'im-select',
			-- '/usr/local/bin/im-select' for binary without extra arguments,
			-- or { "AIMSwitcher.exe", "--imm" } for binary need extra arguments to work.
			-- For Windows/WSL, default: "im-select.exe"
			-- For macOS, default: "macism"
			-- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus""
			default_command = default_command,

			-- Restore the default input method state when the following events are triggered
			set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

			-- Restore the previous used input method state when the following events
			-- are triggered, if you don't want to restore previous used im in Insert mode,
			-- e.g. deprecated `disable_auto_restore = 1`, just let it empty
			-- as `set_previous_events = {}`
			set_previous_events = {},

			-- Show notification about how to install executable binary when binary missed
			keep_quiet_on_no_binary = false,

			-- Async run `default_command` to switch IM or not
			async_switch_im = true,
		})
	end,
}
