{
  opts = {
    laststatus = 3; # One bar at the bottom for all windows
    showmode = false; # Hide default -- INSERT -- (Mini shows it better)
  };

  plugins.lsp-lines = {
    enable = true;
  };

  extraConfigLua = ''
    vim.diagnostic.config({
    virtual_lines = { only_current_line = true },
      virtual_text = false,
      signs = true,
      underline = true,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
      },
    })
  '';

  plugins.mini = {
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

  # Set the global background to dark
  opts.background = "dark";

  plugins.fidget = {
    enable = true;
  };

}
