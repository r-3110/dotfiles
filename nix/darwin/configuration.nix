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

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = false;

    # User owning the Homebrew prefix
    user = "ryo";
  };

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
      "awsesh-beta"
    ];
    taps = [
      "clawscli/tap"
      "elva-labs/elva"
      "tonisives/tap"
    ];
    casks = [
      "activitywatch"
      "aquaskk"
      "blackhole-16ch"
      "box-drive"
      "macskk"
      "notion"
      "tonisives/tap/ovim"
      "google-chrome"
      "clawscli/tap/claws"
      "slack"
      "ghostty"
    ];
    # https://apps.apple.com/jp
    masApps = {
      kindle = 302584613;
    };
  };
}
