{
  opts = {
    laststatus = 3; # One bar at the bottom for all windows
    showmode = false; # Hide default -- INSERT -- (Mini shows it better)
    background = "dark";
  };

  highlightOverride = {
    NormalFloat.bg = "NONE";
    FloatBorder.bg = "NONE";
    FloatTitle = {
      bg = "NONE";
      bold = true;
    };
  };

  colorschemes.gruvbox-material = {
    enable = true;
    settings = {
      # Options: 'hard', 'medium', 'soft'
      background = "medium";
      # Better contrast for the UI
      foreground = "material";
      # Tells the plugin to use the dark variant
      important_style = "bold";
    };
  };

  plugins = {
    lsp-lines = {
      enable = true;
    };

    mini = {
      enable = true;
      modules = {
        icons = { };
        statusline = {
          use_icons = true;
          # set_vim_settings = true; # Standard Mini behavior
        };
      };
      mockDevIcons = true; # THIS IS KEY: It prevents errors in Telescope/Lualine
    };

    # Enable the colorscheme plugin

    # Set the global background to dark

    fidget = {
      enable = true;
    };
  };

  # virtual_lines = { only_current_line = true },
  extraConfigLua = ''
    vim.diagnostic.config({
      virtual_text = {
        spacing = 2,
        source = "if_many"
      },
      signs = true,
      underline = true,
      severity_sort = true,
      update_in_insert = false;
      float = {
        border = "rounded",
        source = "if_many"
      },
    })
    vim.lsp.set_log_level("ERROR")
  '';

}
