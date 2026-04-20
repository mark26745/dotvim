# dotvim

A minimal, reproducible Neovim configuration built with Nix and Nixvim.

This repository provides a fast, declarative editor setup with a focus on performance, simplicity, and portability. It is designed to work consistently across systems using Nix flakes.

---

## Features

* **Declarative configuration** via Nix
* **Reproducible environment** across machines
* **Built-in LSP support** for multiple languages
* **Fast completion engine** using blink.cmp
* **Asynchronous formatting** via conform.nvim
* **Lightweight LSP progress UI** using fidget.nvim
* Minimal plugin set with emphasis on speed and clarity

---

## Structure

```
.
├── flake.nix        # Entry point
└── nvim/            # Nixvim module (editor configuration)
```

* `flake.nix` builds the Neovim package and development shell
* `nvim/` contains the actual editor configuration as a reusable module

---

## Usage

### Run Neovim directly

```bash
nix run
```

---

### Enter development shell

```bash
nix develop
```

This provides:

* the configured Neovim instance
* required runtime dependencies

---

### Build the package

```bash
nix build
```

---

## Reuse as a module

This configuration can be imported into other flakes:

```nix
imports = [
  inputs.dotvim.nixvimModules.default
];
```

---

## Language Support

Configured LSP servers:

* Nix (`nixd`)
* Go (`gopls`)
* Python (`pyright`)
* TypeScript / JavaScript (`typescript-language-server`)

---

## Design Goals

* Keep startup time and runtime overhead low
* Prefer native Neovim features over heavy abstractions
* Avoid unnecessary UI layers
* Maintain clear separation between configuration and tooling
* Ensure reproducibility through Nix

---

## Notes

* LSP progress is displayed via fidget.nvim when supported by the language server
* Some LSPs (e.g. TypeScript, Nix) emit minimal progress events
* Formatting is handled asynchronously and does not block editing

---

## License

MIT

