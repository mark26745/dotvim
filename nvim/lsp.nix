{ pkgs, ... }:

{
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      go
      gomod
      gowork
      gosum
      python
      typescript
      javascript
      tsx
      html
      css
      lua
      vimdoc
      query
      regex
      dockerfile
      yaml
      json
      toml
      bash
      markdown
      markdown_inline
      rust
      diff
      gitcommit
    ];
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };

  plugins.ts-autotag.enable = true;
  plugins.treesitter-context = {
    enable = true;
    settings.max_lines = 3;
  };

  # Supplies default configs (root markers, settings) for every server below
  plugins.lspconfig.enable = true;

  lsp = {
    servers = {
      nixd.enable = true;
      gopls.enable = true;
      pyright.enable = true;
      ts_ls.enable = true;
      lua_ls.enable = true;
      bashls.enable = true;
      jsonls.enable = true;
      dockerls.enable = true;
      docker_compose_language_service.enable = true;
      ansiblels.enable = true;
      yamlls = {
        enable = true;
        config.settings.yaml.schemaStore = {
          enable = true;
          url = "https://www.schemastore.org/api/json/catalog.json";
        };
      };
    };

    keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gD";
        lspBufAction = "declaration";
      }
      {
        key = "gy";
        lspBufAction = "type_definition";
      }
      {
        key = "<leader>rn";
        lspBufAction = "rename";
      }
      {
        key = "<leader>ca";
        lspBufAction = "code_action";
      }
      {
        key = "<leader>cd";
        action.__raw = "vim.diagnostic.open_float";
      }
      # K, grn, gra, grr, gri are already Neovim 0.11 defaults
    ];
  };

  filetype.pattern = {
    "docker%-compose.*%.ya?ml" = "yaml.docker-compose";
    "compose%.ya?ml" = "yaml.docker-compose";
    ".*/ansible/.*%.ya?ml" = "yaml.ansible";
    ".*playbook%.ya?ml" = "yaml.ansible";
  };
}
