{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "github:DeterminateSystems/determinate";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    skills = {
      url = "path:./nix/skills";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp = {
      url = "path:./nix/mcp";
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
      nix-homebrew,
      llm-agents,
      skills,
      mcp,
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
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./nix/home/common.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
              home.packages = [
                llm-agents.packages.${system}.copilot-cli
                llm-agents.packages.${system}.gemini-cli
                llm-agents.packages.${system}.claude-code
                llm-agents.packages.${system}.codex
                llm-agents.packages.${system}.opencode
              ];
            }
          ]
          ++ extraModules;
        };
    in
    {
      # macOS for work
      homeConfigurations."macos-work" = mkHomeConfiguration "aarch64-darwin" "ryo" "/Users/ryo" [
        skills.homeManagerModules.default
        mcp.homeManagerModules.default
        ./nix/home/macos-work.nix
      ];

      # Linux (x86_64)
      homeConfigurations."linux" = mkHomeConfiguration "x86_64-linux" "ryo" "/home/ryo" [
        skills.homeManagerModules.default
        mcp.homeManagerModules.default
        ./nix/home/linux.nix
      ];

      # デフォルト設定（macOS Apple Silicon）
      homeConfigurations."macos" = mkHomeConfiguration "aarch64-darwin" "ryo" "/Users/ryo" [
        skills.homeManagerModules.default
        mcp.homeManagerModules.default
        ./nix/home/macos.nix
      ];

      # nix-darwin configuration (macOS for work)
      darwinConfigurations."macos-work" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          determinate.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          ./nix/darwin/configuration.nix
        ];
      };
    };
}
