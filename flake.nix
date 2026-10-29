{
  description = "My reusable nixvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = ./nvim;
        };
        nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;
      in
      {
        packages.default = nvim;

        checks.default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;

        formatter = pkgs.nixfmt-tree;

        devShells.default = pkgs.mkShell {
          packages = [
            nvim
            pkgs.wl-clipboard
            pkgs.just
          ];
        };
      }
    )
    // {
      nixvimModules.default = import ./nvim;
    };
}
