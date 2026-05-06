{
  inputs,
  pkgs,
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

in
{
  imports = [
    inputs.mcp-servers.homeManagerModules.default
  ];

  programs.mcp.enable = true;

  xdg.configFile = {
    "opencode/opencode.json".source = builtins.toPath opencodeConfig;
  };

  # readonlyだとclaudeが起動しないめ、単純に上書きする
  home.activation.claude = ''
    cp -f ${claudeConfig} $HOME/.claude.json
  '';
}
