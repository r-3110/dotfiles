-- @see https://wezfurlong.org/wezterm/config/files.html
-- @see https://wezfurlong.org/wezterm/config/lua/general.html

---@type Wezterm
local wezterm = require("wezterm")

-- This will hold the configuration.
---@type Config
local config = wezterm.config_builder()

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	---@diagnostic disable-next-line: unused-local
	-- luacheck: ignore 211
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)


local WORKSPACE_COLORS = {
  default = "#80EBDF",
  copy_mode = "#ffd700",
  setting_mode = "#39FF14",
}

-- 前回の色を記録（不要な更新を避けるため）
local last_color = nil

-- ステータスバー更新（ワークスペース名表示 & カーソル色変更）
wezterm.on("update-status", function(window, pane)
	local workspace = window:active_workspace()
	local key_table = window:active_key_table()
	local color = WORKSPACE_COLORS[key_table] or WORKSPACE_COLORS.default

	-- ワークスペース名の色を変更（全モード対応）
	window:set_left_status(wezterm.format({
		{ Background = { Color = "transparent" } },
		{ Foreground = { Color = color } },
		{ Text = "  " .. workspace .. "  " },
	}))

	-- カーソル色変更（OSCエスケープシーケンスを使用）
	if last_color ~= color then
		last_color = color
		-- OSC 12 でカーソル色を変更: \x1b]12;<color>\x1b\\
		pane:inject_output("\x1b]12;" .. color .. "\x1b\\")
	end
end)

-- This is where you actually apply your config choices
config.leader = {
	key = "q",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

-- For example, changing the color scheme:
config.color_scheme = "iceberg-dark"

config.initial_rows = 35
config.initial_cols = 120
config.font_size = 16.0
config.font = wezterm.font_with_fallback({
	"HackGen35 Console NF",
})

-- and finally, return the configuration to wezterm
config.macos_window_background_blur = 20

---@diagnostic disable-next-line: assign-type-mismatch
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

local act = wezterm.action

config.key_tables = {
	-- @see https://wezterm.org/copymode.html
	copy_mode = {
		-- 移動
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		-- 最初と最後に移動
		{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		-- 左端に移動
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		--
		{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
		-- 単語ごと移動
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
		-- ジャンプ機能 t f
		{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
		{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
		{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		-- 一番下へ
		{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
		-- 一番上へ
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
		-- viweport
		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		-- スクロール
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
		{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
		-- 範囲選択モード
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
		{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		-- コピー
		{ key = "y", mods = "NONE", action = act.CopyTo("Clipboard") },

		-- コピーモードを終了
		{
			key = "Enter",
			mods = "NONE",
			action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
		},
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
	},
}

config.keys = {
	{
		mods = "CTRL",
		key = "P",
		action = wezterm.action.ActivateCommandPalette,
	},
	-- splitting
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- pane move
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	-- pane zoom
	{
		mods = "LEADER",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "CTRL",
		key = "=",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		mods = "CTRL",
		key = "-",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		mods = "CTRL",
		key = "0",
		action = wezterm.action.ResetFontSize,
	},
	-- 画面最大化。画面サイズが変わった際にfitにも使える
	{
		key = "f",
		mods = "SHIFT|META",
		action = wezterm.action_callback(function(win)
			win.maximize(win)
		end),
	},
}

return config
