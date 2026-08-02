---
paths:
  - ".config/nvim/**/*.lua"
  - ".config/nvim/**/*.vim"
  - ".vimrcs/**/*.vim"
---

# Neovim Configuration

- option、keymap、autocmd、プラグイン設定の責務を分離する。
- 共通 utility とプラグイン固有処理を分離する。
- 既存の遅延ロード条件と起動順序を維持する。
- 新しい global state を避け、module の戻り値として公開する。
- 変更後は formatter を実行し、可能なら headless Neovim で起動確認する。
