---
paths:
  - "flake.nix"
  - "flake.lock"
  - "nix/**/*.nix"
---

# Dotfiles Home Manager

- Home Manager の管理対象は、ホームディレクトリへ手作業でコピーせず、Nix 設定から配布する。
- 永続化する設定は `nix/home/common.nix` または責務に対応する module へ置く。
- activation script は既存ファイルを考慮し、削除や上書きが必要な場合は事前に確認する。
- Nix ファイルの変更後は、変更対象へ `nixfmt --check` を実行する。
- `nix/home/common.nix` の変更後は、`nix-instantiate --parse nix/home/common.nix` を実行する。
- Home Manager configuration は仕事用と個人用に分かれている。
- activation package の build、switch、apply を行う前に、対象 configuration をユーザーへ確認する。
- 対象 configuration を推測したり、既定値として `macos-work` を選んだりしない。
- configuration が指定されていない場合は、formatter と構文検証までに留める。
- `nix build`、`home-manager switch`、flake 入力の更新は、ユーザーがその操作を明示的に承認した場合だけ実行する。
- `flake.lock` は入力更新を依頼された場合だけ変更する。
