{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Darwin configuration
  system.stateVersion = 6;

  # Primary user for system-level operations
  system.primaryUser = "ryo";

  # Disable nix management (using Determinate instead)
  nix.enable = false;

  # Homebrew configuration
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    brews = [
      "mac-cleanup-go"
    ];
    taps = [
      "clawscli/tap"
      "elva-labs/elva"
    ];
    casks = [
      "activitywatch"
      "aquaskk"
      "blackhole-16ch"
      "box-drive"
      "macskk"
      "notion"
      "ovim"
      "google-chrome"
      "claws"
      "awsesh-beta"
    ];
    # https://apps.apple.com/jp
    masApps = {
      kindle = 302584613;
    };
  };
}
