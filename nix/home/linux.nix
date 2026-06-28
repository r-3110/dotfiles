{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Linux専用のパッケージやサービスをここに追加できます
  home.packages = with pkgs; [
    mise
    ecspresso
    markitdown-mcp
  ];

  # Linux固有の設定をここに追加
}
