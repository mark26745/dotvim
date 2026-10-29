build:
  nix build .#default

check:
  nix flake check

test:
  nix run {{justfile_directory()}}#default -- {{invocation_directory()}}
