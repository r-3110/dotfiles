{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code-nix = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arto = {
      url = "github:arto-app/Arto";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      claude-code-nix,
      arto,
      determinate,
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
              _module.args = {
                inherit system arto;
              };
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
      homeConfigurations."linux" = mkHomeConfiguration "x86_64-linux" "ryo" "/home/ryo" [
        ./nix/home/linux.nix
      ];

      # デフォルト設定（macOS Apple Silicon）
      homeConfigurations."macos" = mkHomeConfiguration "aarch64-darwin" "ryo" "/Users/ryo" [
        ./nix/home/macos.nix
      ];

      # nix-darwin configuration (macOS for work)
      darwinConfigurations."macos-work" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          determinate.darwinModules.default
          ./nix/darwin/configuration.nix
        ];
      };
    };
}
