{
  description = "mcp";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
