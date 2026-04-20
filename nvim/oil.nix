{
  plugins.oil = {
    enable = true;
    settings = {
      # Use default icons (requires the web-devicons/mini.icons we discussed)
      useDefaultKeymaps = true;
      viewOptions = {
        # Show files that start with a dot
        showHidden = true;
      };
    };
  };

  # Custom logic: Open Oil when opening a directory or starting empty
  autoCmd = [
    {
      event = [ "VimEnter" ];
      callback = {
        __raw = ''
          function()
            local arg = vim.fn.argv(0)
            if arg == "" then
              require("oil").open()
            elseif vim.fn.isdirectory(arg) == 1 then
              require("oil").open(arg)
            end
          end
        '';
      };
    }
  ];

  # Shortcut to open Oil manually
  keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<cmd>Oil<CR>";
      options.desc = "Open Oil (Parent Directory)";
    }
  ];
}
