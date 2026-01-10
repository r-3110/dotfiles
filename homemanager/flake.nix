{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      isDarwin = pkgs.stdenv.isDarwin;
    in
    {
      homeConfigurations."ryo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            home.username = "ryo";
            home.homeDirectory = "/Users/ryo";
            home.stateVersion = "24.05";

            home.packages = with pkgs; [
              # Programming Languages
              bun
              deno
              go
              jdk
              lua5_4
              maven
              nodejs_24
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

              initContent = ''
                # Nix
                if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
                fi
                # End Nix

                # Home Manager session variables
                . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

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
            xdg.configFile."sheldon/plugins.toml".source = ../.config/sheldon/plugins.toml;
          }
        ];
      };
    };
}
