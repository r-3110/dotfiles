{
  description = "mcp";

  inputs = {
    mcp-servers.url = "github:natsukium/mcp-servers-nix";
  };

  outputs =
    inputs@{ self, ... }:
    {
      homeManagerModules.default = { ... }@args: import ./default.nix (args // { inherit inputs; });
    };
}
