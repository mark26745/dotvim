{
  extraConfigLua = ''
       vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
      },
    })
  '';

  plugins.blink-cmp = {
    enable = true;

    settings = {
      sources = {
        default = [
          "lsp"
          "snippets"
          "path"
          "buffer"
        ];

        providers = {
          lsp = {
            score_offset = 100;
          };

          snippets = {
            score_offset = 50;
          };

          path = {
            score_offset = 25;
          };

          buffer = {
            score_offset = -10;
          };
        };
      };

      completion = {
        menu = {
          auto_show = true;
        };

        list = {
          selection = {
            preselect = true;
            auto_insert = false;
          };
        };
      };

      # -----------------------------
      # Keymap (keep simple & fast)
      # -----------------------------
      keymap = {
        preset = "default";

        # Move through completion items
        "<Tab>" = [
          "select_next"
          "snippet_forward"
          "fallback"
        ];

        "<S-Tab>" = [
          "select_prev"
          "snippet_backward"
          "fallback"
        ];

        # Confirm selection
        "<CR>" = [
          "accept"
          "fallback"
        ];

        # Manual trigger
        "<C-Space>" = [
          "show"
        ];
      };
    };
  };
}
