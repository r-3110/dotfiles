#!/bin/bash

# Raycast Script Command Configuration
# @raycast.schemaVersion 1
# @raycast.title Neovim IME
# @raycast.mode silent
# @raycast.packageName Utilities

export PATH="$HOME/.nix-profile/bin:$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"

# 1. 現在アクティブなアプリの名前を取得
ACTIVE_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

# 2. 現在の入力欄のテキストをすべて選択してコピー（編集中の文字があれば吸い上げる）
osascript -e 'tell application "System Events" to keystroke "a" using command down'
osascript -e 'tell application "System Events" to keystroke "c" using command down'
sleep 0.15

# 3. 一時ファイルを作成し、コピーした内容を書き込む
TMP_FILE="/tmp/nvim_ime_buffer.txt"
pbpaste >"$TMP_FILE"

# 4. WezTermを「IME専用のサイズ」で起動し、Neovimを開く
wezterm start \
  --class "nvim-ime" \
  --always-new-process \
  --position 300,200 \
  -- nvim -c "startinsert" "$TMP_FILE" &

WEZTERM_PID=$!

# WezTermが起動してから前面に出す
sleep 0.3
osascript -e 'tell application "WezTerm" to activate'

# --- ここでNeovimが閉じられるまでスクリプトは待機します ---
wait $WEZTERM_PID

# 5. Neovimが保存終了（:wq）されたら、ファイルをクリップボードに書き戻す
if [ -f "$TMP_FILE" ]; then
  cat "$TMP_FILE" | pbcopy
  rm "$TMP_FILE"
fi

# 6. 元のアプリにフォーカスを戻し、ペーストする
osascript -e "tell application \"$ACTIVE_APP\" to activate"
sleep 0.15
osascript -e 'tell application "System Events" to keystroke "v" using command down'
