#!/bin/bash

# Raycast Script Command Configuration
# @raycast.schemaVersion 1
# @raycast.title Neovim IME
# @raycast.mode silent
# @raycast.packageName Utilities

export PATH="$HOME/.nix-profile/bin:$HOME/.local/share/mise/shims:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

TMP_FILE="/tmp/nvim_ime_buffer.txt"
SESSION_FILE="/tmp/nvim_ime_session.txt"
DONE_FILE="/tmp/nvim_ime_done.txt"
TMUX_SESSION="nvim-ime"
WEZTERM_BIN="${WEZTERM_BIN:-$(command -v wezterm || true)}"

ensure_nvim_ime_tmux() {
  if ! tmux has-session -t "$TMUX_SESSION" 2>/dev/null; then
    tmux new-session -d -s "$TMUX_SESSION" "nvim '$TMP_FILE'"
  fi
}

focus_nvim_ime() {
  if ! tmux list-clients -t "$TMUX_SESSION" >/dev/null 2>&1; then
    if [ -n "$WEZTERM_BIN" ]; then
      "$WEZTERM_BIN" start \
        --class "nvim-ime" \
        --always-new-process \
        --position 300,200 \
        -- zsh -lc "exec tmux attach -t '$TMUX_SESSION'" nvim-ime &
      sleep 0.3
    else
      osascript -e 'display notification "wezterm command not found" with title "Neovim IME"'
      return 1
    fi
  fi

  osascript -e 'tell application "WezTerm" to activate'
}

# 1. 現在アクティブなアプリの名前を取得
ACTIVE_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

# 2. 現在の入力欄のテキストをすべて選択してコピー（編集中の文字があれば吸い上げる）
osascript -e 'tell application "System Events" to keystroke "a" using command down'
osascript -e 'tell application "System Events" to keystroke "c" using command down'
sleep 0.15

# 3. 一時ファイルを作成し、コピーした内容を書き込む
SESSION_ID="$(date +%s).$$"

printf '%s\n' "$SESSION_ID" >"$SESSION_FILE"
pbpaste >"$TMP_FILE"

# 4. IME用tmuxセッションを用意して、WezTermで前面に出す
ensure_nvim_ime_tmux
focus_nvim_ime || exit 1

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
