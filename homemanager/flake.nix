{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        isDarwin = pkgs.stdenv.isDarwin;
      in
      {
        homeManagerModules.default = { config, lib, pkgs, ... }:
        {
          home.packages = with pkgs; [
            # Programming Languages
            bun
            deno
            go
            jdk
            lua5_4
            maven
            nodejs_22
            python313
            ruby_3_4
            rustc
            cargo

            # CLI Tools
            act
            aws-sso-cli
            awscli2
            bat
            cloudflared
            delta
            ecspresso
            eza
            fd
            fzf
            gh
            ghq
            git-open
            gitui
            jq
            lazydocker
            lazygit
            neovim
            pulumi-bin
            ripgrep
            sheldon
            starship
            tmux
            uv
            yazi
            yq-go
            zellij
            zoxide
            google-cloud-sdk
            flutter
            android-tools
            jujutsu
            ov
            zsh
          ] ++ pkgs.lib.optionals isDarwin [
            # macOS only
            macskk
            wezterm
          ];

          programs.zsh = {
            enable = true;
            enableCompletion = true;

            initExtra = ''
              # Sheldon plugin manager (manages all zsh plugins)
              eval "$(sheldon source)"

              # Zoxide
              eval "$(zoxide init zsh)"

              # Starship
              eval "$(starship init zsh)"

              # FZF
              eval "$(fzf --zsh)"
            '';
          };

          # Copy sheldon configuration
          xdg.configFile."sheldon/plugins.toml".source = ../config/sheldon/plugins.toml;
        };
      }
    );
}
