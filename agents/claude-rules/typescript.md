---
paths:
  - "**/*.{ts,tsx,mts,cts}"
  - "**/package.json"
  - "**/tsconfig*.json"
---

# TypeScript

- 状態、ドメインロジック、I/O を分離する。
- 公開 API と型のコントラクトを先に定義し、実装詳細を閉じ込める。
- 外部入力は `unknown` として受け取り、境界で検証する。安易に `any` を追加しない。
- package manager と実行コマンドは lockfile と既存スクリプトから判断する。
- 既存の formatter、linter、TypeScript 設定を優先する。
- 変更後は、影響範囲に近い typecheck とテストから実行する。
