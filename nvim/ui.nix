{ ... }:

{

  plugins.mini = {
    enable = true;
    modules.icons = {};
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
}
