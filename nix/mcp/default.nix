{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  mcp = inputs.mcp-servers.lib;

  baseConfig = {
    programs = {
      context7.enable = true;
      # nixos.enable = true;
    };

    settings.servers = {
      github = {
        enable = true;
        type = "http";
        url = "https://api.githubcopilot.com/mcp/";
        # Codex uses bearer_token_env_var in ~/.codex/config.toml.
        bearer_token_env_var = "GITHUB_MCP_PAT";
        headers = {
          Authorization = "Bearer \${GITHUB_MCP_PAT}";
        };
      };

      aws-mcp = {
        command = "uvx";
        args = [
          "mcp-proxy-for-aws@latest"
          "https://aws-mcp.us-east-1.api.aws/mcp"
          "--metadata"
          "AWS_REGION=us-west-2"
        ];
      };

      markitdown-mcp = {
        command = "markitdown-mcp";
        args = [ ];
      };

      deepwiki-mcp = {
        type = "http";
        url = "https://mcp.deepwiki.com/mcp";
      };

      context-mode = {
        command = "context-mode";
      };

      dbhub = {
        command = "npx";
        args = [
          "@bytebase/dbhub@latest"
          "--config"
          "~/dotfiles/.config/dbhub/dbhub.toml"
          "--transport"
          "stdio"
        ];
      };
    };
  };

  claudeConfig = mcp.mkConfig pkgs (
    baseConfig
    // {
      flavor = "claude-code";
    }
  );

  opencodeConfig = mcp.mkConfig pkgs (
    pkgs.lib.recursiveUpdate baseConfig {
      flavor = "opencode";
      settings."$schema" = "https://opencode.ai/config.json";
    }
  );

  codexConfig = mcp.mkConfig pkgs (
    pkgs.lib.recursiveUpdate baseConfig {
      flavor = "codex";
      format = "toml";
    }
  );

in
{
  imports = [
    inputs.mcp-servers.homeManagerModules.default
  ];

  programs.mcp.enable = true;

  xdg.configFile = {
    "opencode/opencode.json".source = builtins.toPath opencodeConfig;
  };

  # readonlyだとclaudeが起動しないめ、symlinkではなく書き込み可能なコピーを置く
  home.activation.claude = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run install -m 600 ${claudeConfig} $HOME/.claude.json
  '';

  # codexもconfig.tomlへ書き込むため、symlinkではなくコピーする
  # 旧世代のsymlinkが残っているとcpがsrc/dest同一と判定して空振りするため、rmしてからinstallする
  home.activation.codex = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run mkdir -p $HOME/.codex
    run rm -f $HOME/.codex/config.toml
    run install -m 600 ${codexConfig} $HOME/.codex/config.toml
  '';
}
