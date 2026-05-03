{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # Programming Languages
    bun
    go
    jdk
    lua5_4
    maven
    ruby_3_4
    rustc
    cargo

    # CLI Tools
    luajitPackages.luarocks
    luajitPackages.luacheck
    gnumake
    awscli2
    bat
    delta
    eza
    fd
    fzf
    ghq
    git
    git-open
    gitui
    mergiraf
    worktrunk
    jq
    lazydocker
    lazygit
    neovim
    pulumi-bin
    ripgrep
    sheldon
    oh-my-posh
    tmux
    uv
    yazi
    yq-go
    zellij
    zoxide
    jujutsu
    ov
    treemd
    zsh
    posting
    nixfmt
    nixfmt-tree
    nix-output-monitor
    nixd
    nix-search-tv
    tree-sitter
    llm-agents.copilot-cli
    llm-agents.gemini-cli
    rtk

    # Font
    hackgen-nf-font
  ];

  programs.home-manager.enable = true;

  programs.nix-search-tv = {
    enable = true;

    settings = {
      experimental = {
        render_docs_indexes = {
          home-manager-docs = "https://nix-community.github.io/home-manager/options.xhtml";
          nix-darwin-docs = "https://nix-darwin.github.io/nix-darwin/manual/index.html";
        };
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/id_ed25519";
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      extraOptions = {
        UseKeychain = "yes";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    envExtra = ''
      export XDG_CONFIG_HOME="$HOME/.config"

      export XDG_DATA_HOME="$HOME/.local/share"

      export MANPAGER=ov

      export EDITOR=nvim

      export ZENO_HOME="$HOME/.config/zeno"

      # masonを優先に
      export PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"
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
      # nixによりcompinitは読み込まれる
      # autoload bashcompinit && bashcompinit

      # Sheldon plugin manager (manages all zsh plugins)
      eval "$(sheldon source)"

      # Zoxide
      eval "$(zoxide init zsh)"

      # oh-my-posh
      source <($HOME/.nix-profile/bin/oh-my-posh init zsh --config $HOME/dotfiles/.config/oh-my-posh/config.yaml)

      # FZF
      eval "$(fzf --zsh)"

      source $HOME/.zsh_functions
    '';
  };

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      prefer_editor_prompt = "enabled";
      pager = "ov";
      color_labels = "enabled";
    };

    extensions = [
      pkgs.gh-dash
    ];
  };

  # Home directory
  home.file = {
    ".wezterm.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/wezterm/.wezterm.lua";
    ".tmux.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.tmux.conf";
    ".zsh_functions".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/zsh/.zsh_functions";
    ".skk".source = pkgs.symlinkJoin {
      name = "skk-dicts";
      paths = builtins.filter (
        drv:
        !(builtins.elem (drv.pname or "") [
          "skk-jisyo-s"
          "skk-jisyo-m"
          "skk-jisyo-ml"
        ])
      ) (builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.skkDictionaries));
    };
    "AGENTS.md".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/agents/AGENTS.md";
    ".gemini/GEMINI.md".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/agents/AGENTS.md";
    ".claude/CLAUDE.md".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/agents/AGENTS.md";
    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/claude/settings.json";
    ".copilot/copilot-instructions.md".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/agents/AGENTS.md";
    ".gemini/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/gemini/settings.json";
    ".copilot/lsp-config.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/copilot/lsp-config.json";
    ".copilot/mcp-config.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/copilot/mcp-config.json";
  };

  # XDG Config files
  xdg.configFile = {
    "nvim/init.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim/init.lua";
    "nvim/lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim/lua";
    "nvim/snippet".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim/snippet";

    "git/config".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/git/.gitconfig";

    "git/attributes".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/git/.gitattributes";

    "wezterm".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/wezterm";

    "sheldon".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/sheldon";

    "yazi/keymap.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/yazi/keymap.toml";

    "yazi/package.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/yazi/package.toml";

    "yazi/yazi.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/yazi/yazi.toml";

    "mise".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/mise";

    "lazygit".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/lazygit";

    "gh-dash".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/gh-dash";

    "ov".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/ov";

    "zeno".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/zeno";

    "neovide".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/neovide";

    "ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/ghostty";

    "basalt".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/basalt";
  };
}
