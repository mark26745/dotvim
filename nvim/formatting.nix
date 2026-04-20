{ pkgs, ... }:

{
  plugins.conform-nvim = {
    enable = true;
  };

  extraPackages = with pkgs; [
    nixfmt
    gofumpt
    ruff
    biome
  ];

  extraConfigLua = ''
    local conform = require("conform")

    conform.setup({
      ------------------------------------------------------------
      -- FAST FORMATTERS ONLY (NO FALLBACK CHAINS)
      ------------------------------------------------------------
      formatters_by_ft = {
        nix = { "nixfmt" },

        go = { "gofmt" },
        gomod = { "gofmt" },

        python = { "ruff_format" },

        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },

        json = { "biome" },
        css = { "biome" },
        html = { "biome" },
      },

      ------------------------------------------------------------
      -- SPEED SETTINGS
      ------------------------------------------------------------
      format_on_save = {
        lsp_fallback = false,   -- 🚀 avoids slow LSP formatting
        timeout_ms = 500,       -- keep it tight
      },
    })

    vim.keymap.set("n", "<leader>f", function()
      conform.format({
        async = true,
        lsp_fallback = false,
      })
    end, { desc = "Fast format buffer" })
  '';
}
