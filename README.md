# dotfiles

## 初回にインストール

1. [nix-installer](https://github.com/DeterminateSystems/nix-installer)でnixをインストール

## 各種インストール

- リモートから実行

1. nix-darwinインストール

   ```zsh
   sudo nix run nix-darwin -- switch --flake github:r-3110/dotfiles#macos-work
   ```

2. home-managerインストール

   ```zsh
   nix run home-manager/master -- switch --flake github:r-3110/dotfiles#<output> -b backup
   ```

- ローカルで実行

1. nix-darwinインストール

   ```zsh
   sudo nix run nix-darwin -- switch --flake .#macos-work
   ```

2. home-managerインストール
   ```zsh
   nix run home-manager/master -- switch --flake .#<output> -b backup
   ```
