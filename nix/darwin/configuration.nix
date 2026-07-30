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
      "awsesh"
      "mo"
      "microsoft/apm/apm"
      "glab-tui"
    ];
    taps = [
      {
        name = "clawscli/tap";
        trusted = true;
      }
      {
        name = "elva-labs/elva";
        trusted = true;
      }
      {
        name = "tonisives/tap";
        trusted = true;
      }
      {
        name = "k1LoW/tap";
        trusted = true;
      }
      {
        name = "rcieri/glab-tui";
        trusted = true;
      }
    ];
    casks = [
      "blackhole-16ch"
      "box-drive"
      "macskk"
      "notion"
      "tonisives/tap/ovim"
      "google-chrome"
      "brave-browser"
      "clawscli/tap/claws"
      "slack"
      "ghostty"
      "microsoft-word"
      "microsoft-excel"
      "microsoft-powerpoint"
    ];
    # https://apps.apple.com/jp
    masApps = {
      kindle = 302584613;
    };
  };
}
