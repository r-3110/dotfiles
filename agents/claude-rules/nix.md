---
paths:
  - "**/*.nix"
  - "flake.lock"
---

# Nix

- 既存の formatter と module 構成を優先する。
- パッケージ定義、設定値、配布処理の関心を分離する。
- activation script は冪等にし、既存データを暗黙に削除しない。
- `flake.lock` は依存関係の更新を依頼された場合だけ変更する。
- 変更後は formatter と構文評価を実行する。
- `nix build`、`nix flake check`、環境への apply は、対象と実行範囲についてユーザーの明示的な承認を得た場合だけ実行する。
- 複数の configuration がある場合は対象を推測せず、未指定ならユーザーへ確認する。
- 検証できない項目は、未実行の理由とともに報告する。
