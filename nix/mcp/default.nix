{
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      opencode = inputs.llm-agents.packages.${prev.stdenv.hostPlatform.system}.opencode;
      claude-code = inputs.llm-agents.packages.${prev.stdenv.hostPlatform.system}.claude-code;
    })
  ];

  imports = [
    inputs.mcp-servers.homeManagerModules.default
  ];
  # enable the centralized mcp server registry
  programs.mcp.enable = true;

  mcp-servers.programs = {
    context7.enable = true;
    nixos.enable = true;
  };

  # Add custom MCP servers
  mcp-servers.settings.servers = {
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
  };

  # each program consumes shared servers via enablemcpintegration
  programs = {
    claude-code = {
      enable = true;
      enableMcpIntegration = true;
    };
    opencode = {
      enable = true;
      enableMcpIntegration = true;
    };
  };
}
