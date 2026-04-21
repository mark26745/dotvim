{ pkgs, ... }:

{

  plugins.treesitter = {
    enable = true;

    # This automatically installs the grammars via Nix
    # No need to manually run :TSInstall
    settings = {
      highlight.enable = true;
      indent.enable = true;

      ensure_installed = [
        "nix"
        "go"
        "gomod"
        "gowork"
        "python"
        "typescript"
        "javascript"
        "tsx"
        "html"
        "css"
        "lua" # Always recommended for Neovim config
        "vimdoc" # For help files
        "dockerfile"
        "yaml"
        "json"
        "bash"
      ];

      # Smart selection: Use 'Enter' to expand selection, 'BS' to shrink
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "gnn";
          node_incremental = "grn";
          scope_incremental = "grc";
          node_decremental = "grm";
        };
      };
    };
  };

  # Essential for TSX/HTML: Auto-close and auto-rename tags
  plugins.ts-autotag.enable = true;

  # Better context: Shows the function/class header at the top of the buffer
  plugins.treesitter-context = {
    enable = true;
    settings.max_lines = 3;
  };

  extraPackages = with pkgs; [
    nixd
    gopls
    pyright
    typescript-language-server
  ];

  extraConfigLua = ''


    ------------------------------------------------------------
    -- SAFETY CHECK (Neovim 0.10+ required)
    ------------------------------------------------------------
    if not vim.lsp.config then
      vim.notify("vim.lsp.config not available (need Neovim 0.10+)", vim.log.levels.ERROR)
      return
    end

    ------------------------------------------------------------
    -- OPTIONAL: blink.nvim capabilities injection
    -- (safe even if blink is not loaded yet)
    ------------------------------------------------------------
    local function capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok and blink and blink.get_lsp_capabilities then
        return blink.get_lsp_capabilities()
      end

      return vim.lsp.protocol.make_client_capabilities()
    end

    ------------------------------------------------------------
    -- LSP SERVERS
    ------------------------------------------------------------

    -- Nix
    vim.lsp.config.nixd = {
      cmd = { "${pkgs.nixd}/bin/nixd" },
      filetypes = { "nix" },
      capabilities = capabilities(),
    }

    -- Go
    vim.lsp.config.gopls = {
      cmd = { "${pkgs.gopls}/bin/gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      capabilities = capabilities(),
    }

    -- Python
    vim.lsp.config.pyright = {
      cmd = { "${pkgs.pyright}/bin/pyright-langserver", "--stdio" },
      filetypes = { "python" },
      capabilities = capabilities(),
    }

    -- TypeScript / JavaScript
    vim.lsp.config.ts_ls = {
      cmd = { "${pkgs.typescript-language-server}/bin/typescript-language-server", "--stdio" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
      capabilities = capabilities(),
    }

      -- Docker
      vim.lsp.config.dockerls = {
      cmd = { "${pkgs.dockerfile-language-server}/bin/docker-language-server", "--stdio" },
      filetypes = { "dockerfile" },
      capabilities = capabilities(),
    }

      -- Docker Compose
    vim.lsp.config.docker_compose_language_service = {
      cmd = { "${pkgs.docker-compose-language-service}/bin/docker-compose-langserver", "--stdio" },
      filetypes = { "yaml.docker-compose", },
      capabilities = capabilities(),
    }

      -- Ansible
    vim.lsp.config.ansiblels = {
      cmd = { "${pkgs.ansible-language-server}/bin/ansible-language-server", "--stdio", },
      filetypes = { "yaml.ansible" },
      capabilities = capabilities(),
    }

      -- YAML (General & Validation)
    vim.lsp.config.yamlls = {
      cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
      filetypes = { "yaml", "yaml.docker-compose", "yaml.ansible" },
      capabilities = capabilities(),
      settings = {
        yaml = {
          schemas = {
             -- Example schema mapping
             ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json"] = "/*playbook.yaml",
          },
        },
        },
      }

    ------------------------------------------------------------
    -- ENABLE SERVERS
    ------------------------------------------------------------
    vim.lsp.enable({
      "nixd",
      "gopls",
      "pyright",
      "ts_ls",
      "dockerls",
      "docker_compose_language_service",
      "ansiblels",
      "yamlls",
    })
  '';

  autoCmd = [
    {
      event = "LspAttach";
      callback = {
        __raw = ''
          function(args)
            local opts = { buffer = args.buf }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          end
        '';
      };
    }
  ];

  filetype = {
    pattern = {
      "docker%-compose.*%.ya?ml" = "yaml.docker-compose";
      ".*/ansible/.*%.ya?ml" = "yaml.ansible";
      ".*playbook%.ya?ml" = "yaml.ansible";
    };
  };

}
