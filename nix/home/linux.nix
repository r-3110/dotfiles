{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Linux専用のパッケージやサービスをここに追加できます
  home.packages = with pkgs; [
    # Linux専用ツールやアプリケーション
  ];

  # Linux固有の設定をここに追加
}
