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

    mise
    colima
    docker
    docker-compose
    docker-buildx
  ];
}
