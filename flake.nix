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

        mkLintCheck =
          name: tool: cmd:
          pkgs.runCommandLocal "${name}-check" { nativeBuildInputs = [ tool ]; } ''
            cd ${self}
            ${cmd}
            touch $out
          '';
      in
      {
        packages.default = nvim;

        checks = {
          default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;
          statix = mkLintCheck "statix" pkgs.statix "statix check .";
          deadnix = mkLintCheck "deadnix" pkgs.deadnix "deadnix --fail .";
        };

        formatter = pkgs.nixfmt-tree;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nvim
            wl-clipboard
            just
            statix
            deadnix
          ];
        };
      }
    )
    // {
      nixvimModules.default = import ./nvim;
    };
}
