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
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages.default = nixvim.legacyPackages.${system}.makeNixvim {
          imports = [
            ./nvim
          ];
        };

        nixvimModules.default = import ./nvim;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            self.packages.${system}.default
            wl-clipboard
            just
          ];
        };
      }
    );
}
