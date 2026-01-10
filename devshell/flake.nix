{
  description = "Development shell configuration";

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
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
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

            # Google Cloud SDK
            google-cloud-sdk

            # Flutter SDK
            flutter

            # Android SDK
            android-tools

            # Zsh (plugins are managed by sheldon)
            zsh

            # Additional tools
            jujutsu  # jj-vcs/jj
            ov       # noborus/ov
          ] ++ pkgs.lib.optionals isDarwin [
            # macOS only
            wezterm
          ];

          shellHook = ''
            # Set up environment variables
            export ZENO_GIT_CAT="${pkgs.bat}/bin/bat --color=always"
            export ZENO_GIT_TREE="${pkgs.eza}/bin/eza --tree"

            # Initialize zoxide
            eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

            # Initialize starship
            eval "$(${pkgs.starship}/bin/starship init zsh)"

            # Initialize fzf
            eval "$(${pkgs.fzf}/bin/fzf --zsh)"

            echo "Development environment loaded!"
            echo "Available tools:"
            echo "  Languages: bun, deno, go, java, lua, maven, node, python, ruby, rust"
            echo "  CLI Tools: bat, eza, fd, fzf, gh, ghq, lazygit, neovim, ripgrep, tmux, yazi, zellij"
            echo "  Cloud: aws-cli, gcloud, pulumi, cloudflared"
            echo "  Zsh managed by sheldon - run 'sheldon lock' to update plugins"
          '';
        };
      }
    );
}
