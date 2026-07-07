#!/bin/bash
# @ mention のファイルサジェスト用カスタムコマンド。
# stdin: {"query": "..."} / stdout: 改行区切りのファイルパス(先頭15件)
query=$(cat | jq -r '.query // ""')
cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || true

files() {
  rg --files --hidden --follow -g '!.git' 2>/dev/null
}

if [ -z "$query" ]; then
  files | head -15
else
  files | fzf --filter="$query" 2>/dev/null | head -15
fi
