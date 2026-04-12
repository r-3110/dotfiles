# dotfiles

<div align="center">

![License](https://img.shields.io/badge/License-MIT-brightgreen?style=flat-square)
![Status](https://img.shields.io/badge/Status-Maintained-informational?style=flat-square)

</div>

## 初回にインストール

1. 下記のいずれかでnixをインストール

- macos
  - [nix-installer](https://github.com/DeterminateSystems/nix-installer)
- wsl2(ubuntu)
  - [nix](https://nix.dev/install-nix)

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
