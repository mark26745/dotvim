{
  plugins.blink-cmp = {
    enable = true;

    settings = {
      fuzzy.implementation = "prefer_rust_with_warning";

      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200; # docs popup without blocking typing
        };
      };

      signature.enabled = true; # function signature help while typing args

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
            min_keyword_length = 3; # stop buffer words flooding the list on 1–2 chars
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
