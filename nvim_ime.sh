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
SESSION_FILE="/tmp/nvim_ime_session.txt"
DONE_FILE="/tmp/nvim_ime_done.txt"
SESSION_ID="$(date +%s).$$"

printf '%s\n' "$SESSION_ID" >"$SESSION_FILE"
pbpaste >"$TMP_FILE"

# 4. 常駐しているNeovim IME用のWezTermを前面に出す
osascript -e 'tell application "WezTerm" to activate'

# --- Neovim側で保存完了するまで待機します ---
while [ "$(cat "$DONE_FILE" 2>/dev/null)" != "$SESSION_ID" ]; do
  sleep 0.05
done

# 5. Neovimが保存完了（<C-s> または ZZ）したら、ファイルをクリップボードに書き戻す
if [ -f "$TMP_FILE" ]; then
  cat "$TMP_FILE" | pbcopy
fi

# 6. 元のアプリにフォーカスを戻し、ペーストする
osascript -e "tell application \"$ACTIVE_APP\" to activate"
sleep 0.15
osascript -e 'tell application "System Events" to keystroke "v" using command down'
