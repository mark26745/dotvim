{ pkgs, ... }:

{
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

    ------------------------------------------------------------
    -- ENABLE SERVERS
    ------------------------------------------------------------
    vim.lsp.enable({
      "nixd",
      "gopls",
      "pyright",
      "ts_ls",
    })
  '';

  autoCmd = [
    {
      event = "LspAttach";
      callback = { __raw = ''
        function(args)
          local opts = { buffer = args.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end
      ''; };
    }
  ];
}
