{
  description = "mcp";

  inputs = {
    mcp-servers.url = "github:natsukium/mcp-servers-nix";
  };

  outputs =
    inputs@{ self, ... }:
    {
      homeManagerModules.default =
        {
          config,
          pkgs,
          lib,
          ...
        }@args:
        import ./default.nix (
          args
          // {
            inherit
              inputs
              config
              pkgs
              lib
              ;
          }
        );
    };
}
