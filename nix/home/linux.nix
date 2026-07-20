{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Linux専用のパッケージやサービスをここに追加できます
  home.packages = with pkgs; [
    keychain
    mise
    ecspresso
    markitdown-mcp
    herdr
  ];

  # Linux固有の設定をここに追加
}
