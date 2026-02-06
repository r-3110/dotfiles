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
    neovide
    raycast
    shortcat
    zoom-us
    podman

    github-copilot-cli
    gemini-cli
    flutter
    libyaml
    nkf
    pkgconf
    skopeo
    translate-shell
    nodePackages.aws-cdk
    zenn-cli
    tree
    gtree
    otree
    as-tree
    ssm-session-manager-plugin
    mise
    resterm
    stu
    regex-tui
  ];
}
