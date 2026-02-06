# dotfiles

## 初回インストール

1. [nix-installer](https://github.com/DeterminateSystems/nix-installer)でnixをインストール

2. このリポジトリをクローン or ダウンロード

3. home-managerでインストール

- macOS

```zsh
nix run home-manager/master -- switch --flake .#macos -b backup
```

## 使い方
