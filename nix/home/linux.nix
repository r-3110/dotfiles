{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Linux専用のパッケージやサービスをここに追加できます
  home.packages = with pkgs; [
    ecspresso
    markitdown-mcp
  ];

  # Linux固有の設定をここに追加
}
