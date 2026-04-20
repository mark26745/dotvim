{ ... }:

{

  plugins.telescope = {
    enable = true;
    # lazyLoad = {
    #   enable = true;
    #   events = [ "CmdlineEnter" ];
    # };
    # Keep dependencies minimal
    extensions = {
      fzf-native.enable = true;
    };

    settings = {
      defaults = {
        prompt_prefix = "❯ ";
        selection_caret = "➜ ";

        sorting_strategy = "ascending";
        layout_strategy = "flex";

        # --- PERFORMANCE / PREVIEW BALANCE ---
        dynamic_preview_title = true;

        preview = {
          filesize_limit = 2; # MB limit to avoid freezing
          treesitter = false; # BIG speed win
        };
      };

      pickers = {
        # --- FILE SEARCH (fd) ---
        find_files = {
          find_command = [
            "fd"
            "--type"
            "f"
            "--hidden"
            "--exclude"
            ".git"
            "--exclude"
            "node_modules"
          ];

          previewer = true;
        };

        # --- LIVE GREP (ripgrep) ---
        live_grep = {
          additional_args = [
            "--hidden"
            "--smart-case"
            "--no-heading"
          ];

          previewer = true;
        };

        # --- MAKE LSP PICKS FAST ---
        lsp_references.previewer = true;
        lsp_definitions.previewer = true;
        diagnostics.previewer = true;
      };
    };
  };


keymaps = [
    # Find files (The most used shortcut)
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Telescope Find Files";
    }
    # Live Grep (Search for text inside files)
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Telescope Live Grep";
    }
    # Buffers (Switch between open files)
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options.desc = "Telescope Buffers";
    }
    # Help tags (Search Neovim documentation)
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options.desc = "Telescope Help Tags";
    }
    # Git Files (Only files tracked by git)
    {
      mode = "n";
      key = "<leader>gf";
      action = "<cmd>Telescope git_files<CR>";
      options.desc = "Telescope Git Files";
    }
];

}
