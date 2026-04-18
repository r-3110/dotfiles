{
  description = "mcp";

  inputs = {
    mcp-servers.url = "github:natsukium/mcp-servers-nix";
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    inputs@{ self, ... }:
    {
      homeManagerModules.default = { ... }@args: import ./default.nix (args // { inherit inputs; });
    };
}
