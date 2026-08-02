---
paths:
  - "agents/**"
  - ".agents/**"
  - ".claude/**"
  - ".config/claude/**"
  - ".config/codex/**"
  - "nix/skills/**"
  - "nix/mcp/**"
---

# Agent Configuration

- 静的な判断基準は instructions または rules、機械的な強制は permissions または hooks に置く。
- ファイル種別やディレクトリ固有の指示には path-scoped rules を使う。
- 複数手順を持つオンデマンド作業は skill にする。
- 共通実装は一か所に置き、各エージェントから参照する。
- hook は入力を信頼せず、タイムアウトと失敗時の方針を明示する。
- 設定変更後は、構文検証と実際のロード元の確認を行う。
