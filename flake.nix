{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code-nix = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      claude-code-nix,
      ...
    }:
    let
      # 複数システムをサポートするヘルパー関数
      mkHomeConfiguration =
        system: username: homeDirectory: extraModules:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              claude-code-nix.overlays.default
            ];
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./nix/home/common.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ]
          ++ extraModules;
        };
    in
    {
      # macOS for work
      homeConfigurations."macos-work" = mkHomeConfiguration "aarch64-darwin" "ryo" "/Users/ryo" [
        ./nix/home/macos-work.nix
      ];

      # Linux (x86_64)
      # homeConfigurations."ryo@x86_64-linux" = mkHomeConfiguration
      #   "x86_64-linux"
      #   "ryo"
      #   "/home/ryo"
      #   [ ./nix/home/linux.nix ];

      # デフォルト設定（macOS Apple Silicon）
      homeConfigurations."macos" = mkHomeConfiguration "aarch64-darwin" "ryo" "/Users/ryo" [
        ./nix/home/macos.nix
      ];
    };
}
