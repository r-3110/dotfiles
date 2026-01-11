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
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          claude-code-nix.overlays.default
        ];
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

            home.packages =
              with pkgs;
              [
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
                clang

                # CLI Tools
                gnumake
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
                git
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
                jujutsu
                ov
                zsh
                posting
                nixfmt
                tree-sitter
                opencode
                claude-code

                #font
                hackgen-nf-font
              ]
              ++ pkgs.lib.optionals isDarwin [
                # macOS only
                macskk
                wezterm
              ];

            programs.home-manager.enable = true;

            programs.zsh = {
              enable = true;
              enableCompletion = true;

              envExtra = ''
                export XDG_DATA_HOME="$HOME/.local/share"

                export MANPAGER=ov

                export EDITOR=nvim

                export ZENO_HOME="$HOME/.config/zeno"

                export PATH="$PATH:$HOME/.local/share/nvim/mason/bin/"
              '';

              shellAliases = {
                ls = "eza --color=always --long --git --icons=always";
                vim = "nvim";
              };

              initContent = ''
                # Nix
                if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
                fi
                # End Nix

                # Home Manager session variables
                . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

                # Enable bash compatibility for some plugins
                autoload bashcompinit && bashcompinit
                autoload -Uz compinit && compinit

                complete -C aws_completer aws


                # Sheldon plugin manager (manages all zsh plugins)
                eval "$(sheldon source)"

                # Zoxide
                eval "$(zoxide init zsh)"

                # Starship
                eval "$(starship init zsh)"

                # FZF
                eval "$(fzf --zsh)"

                source $HOME/.zsh_functions
              '';
            };

            # Home directory
            home.file = {
              ".wezterm.lua".source = ./.config/wezterm/.wezterm.lua;
              ".gitconfig".source = ./.gitconfig;
              ".zsh_functions".source = ./.config/zsh/.zsh_functions;
            };

            # XDG Config files
            xdg.configFile = {
              "nvim/init.lua".source = ./.config/nvim/init.lua;
              "nvim/lua".source = ./.config/nvim/lua;
              "nvim/snippet".source = ./.config/nvim/snippet;

              "wezterm".source = ./.config/wezterm;

              "starship.toml".source = ./.config/starship/starship.toml;

              "sheldon".source = ./.config/sheldon;

              "yazi".source = ./.config/yazi;

              "lazygit".source = ./.config/lazygit;

              "gh-dash".source = ./.config/gh-dash;

              "ov".source = ./.config/ov;

              "zeno".source = ./.config/zeno;

              "neovide".source = ./.config/neovide;

            };
          }
        ];
      };
    };
}
