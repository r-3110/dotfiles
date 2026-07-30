{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  mcp = inputs.mcp-servers.lib;

  baseConfig = {
    settings.servers = {
      markitdown-mcp = {
        type = "http";
        url = "http://127.0.0.1:8811/servers/markitdown-mcp/mcp";
      };

      chrome-devtools = {
        command = "npx";
        args = [
          "-y"
          "chrome-devtools-mcp@latest"
          "--slim"
          "--headless"
        ];
      };

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

      deepwiki-mcp = {
        type = "http";
        url = "https://mcp.deepwiki.com/mcp";
      };

      context-mode = {
        command = "context-mode";
      };

      # mcp-proxyで起動するmcp
      semgrep = {
        type = "http";
        url = "http://127.0.0.1:8811/servers/semgrep/mcp";
      };

      dbhub = {
        type = "http";
        url = "http://127.0.0.1:8811/servers/dbhub/mcp";
      };

      context7 = {
        type = "http";
        url = "https://mcp.context7.com/mcp";
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
      settings.servers = {
        markitdown-mcp.enabled = false;
        chrome-devtools.enabled = false;
        dbhub.enabled = false;
      };
      settings.features = {
        plugin_hooks = true;
        hooks = true;
      };
      # keyはmanifest.jsonのnameに対応する
      settings.marketplaces.sisyphuslabs = {
        source_type = "git";
        source = "https://github.com/code-yeongyu/lazycodex.git";
      };
      settings.marketplaces.context-mode = {
        source_type = "git";
        source = "https://github.com/mksglu/context-mode.git";
      };
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
