{
  plugins.blink-cmp = {
    enable = true;

    settings = {
      fuzzy.implementation = "prefer_rust_with_warning";

      completion = {
        menu = {
          auto_show = true;
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 500; # docs popup without blocking typing
        };
      };

      signature.enabled = true; # function signature help while typing args

      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
        ];

        providers = {
          lsp = {
            fallbacks = [ "buffer" ];
            score_offset = 100;
          };

          snippets = {
            score_offset = 50;
          };

          path = {
            score_offset = 25;
          };

          buffer = {
            score_offset = -5;
            max_items = 5;
            min_keyword_length = 4; # stop buffer words flooding the list on 1–2 chars
            opts = {
              max_sync_buffer_size = 20000;
              max_async_buffer_size = 200000;
              max_total_buffer_size = 500000;
              use_cache = true;

            };
          };
        };
      };

      list = {
        selection = {
          preselect = true;
          auto_insert = false;
        };
      };
    };
  };

  # # -----------------------------
  # # Keymap (keep simple & fast)
  # # -----------------------------
  # keymap = {
  #   preset = "default";
  #
  #   # Move through completion items
  #   "<Tab>" = [
  #     "select_next"
  #     "snippet_forward"
  #     "fallback"
  #   ];
  #
  #   "<S-Tab>" = [
  #     "select_prev"
  #     "snippet_backward"
  #     "fallback"
  #   ];
  #
  #   # Confirm selection
  #   "<CR>" = [
  #     "accept"
  #     "fallback"
  #   ];
  #
  #   # Manual trigger
  #   "<C-Space>" = [
  #     "show"
  #   ];
  # };
}
