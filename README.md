# dotfiles

## 初回にインストール

1. [nix-installer](https://github.com/DeterminateSystems/nix-installer)でnixをインストール

2. このリポジトリをクローン or ダウンロード

## 各種インストール

1. nix-darwinインストール
   - macOS (work)

   ```zsh
   sudo nix run nix-darwin -- switch --flake .#macos-work
   ```

2. home-managerインストール
   - macOS

   ```zsh
   nix run home-manager/master -- switch --flake .#macos -b backup
   ```
