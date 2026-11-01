{ pkgs, ... }:
{
  plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      use_default_keymaps = true;
      watch_for_changes = false;
      view_options.show_hidden = true;

      keymaps = {
        "<Esc>" = "actions.close";
      };

      float = {
        padding = 2;
        max_width = 0.85;
        max_height = 0.85;
        border = "rounded";
        preview_split = "below"; # preview stacked under the file list ("above" also works)
      };

      preview_win = {
        update_on_cursor_moved = true;
        # Real buffers so snacks.image can draw images; scratch previews can't
        preview_method = "load";
        # Skip previewing big non-image files to keep it snappy
        disable_preview.__raw = ''
          function(filename)
            local size = vim.fn.getfsize(filename)
            local is_image = filename:match("%.png$") or filename:match("%.jpe?g$")
              or filename:match("%.gif$") or filename:match("%.webp$")
            return not is_image and size > 1024 * 1024
          end
        '';
      };
    };
  };

  # Custom logic: Open Oil when opening a directory or starting empty
  plugins.snacks = {
    enable = true;
    settings.image = {
      enabled = true;
      doc.enabled = true; # also show images inline in markdown
    };
  };
  # Converts formats kitty can't take directly (jpg, webp, svg, gif frames…)
  extraPackages = with pkgs; [
    imagemagick
    ghostscript_headless
  ];

  autoCmd = [
    {
      event = [ "VimEnter" ];
      callback.__raw = ''
        function()
          local arg = vim.fn.argv(0)
          local oil = require("oil")
          if arg == "" then
            oil.open_float(nil, { preview = {} })
          elseif vim.fn.isdirectory(arg) == 1 then
            -- Replace the directory buffer oil opened with the float
            local dirbuf = vim.api.nvim_get_current_buf()
            vim.cmd.enew()
            pcall(vim.api.nvim_buf_delete, dirbuf, { force = true })
            oil.open_float(arg, { preview = {} })
          end
        end
      '';
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "-";
      action.__raw = ''function() require("oil").open_float(nil, { preview = {} }) end'';
      options.desc = "Oil (float, with preview)";
    }
  ];

}
