{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # macOS only
    macskk
    wezterm
    raycast
    podman
  ];
}
