build:
  nix build .#default

test: build
  ./result/bin/nvim .
