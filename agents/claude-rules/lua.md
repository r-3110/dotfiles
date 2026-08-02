---
paths:
  - "**/*.lua"
  - "**/.luarc.json"
---

# Lua

- 状態を持つ設定と再利用可能なロジックを分離する。
- Neovim 設定では、プラグイン固有の副作用をその設定境界に閉じ込める。
- 共通処理は小さな module とし、暗黙の global を追加しない。
- 既存の formatter と Lua language server の設定を優先する。
- Neovim 設定を変更した場合は、可能なら headless 起動で読み込みを確認する。
