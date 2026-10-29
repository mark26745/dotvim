{
  plugins.diffview = {
    enable = true;
  };

  plugins.neogit = {
    enable = true;
    settings = {
      kind = "floating";

      commit_editor = {
        kind = "floating";
      };

      popup = {
        kind = "floating";
      };

      preview_buffer = {
        kind = "floating";
      };

      integrations = {
        diffview = false;
      };

      mappings = {
        status = {
          a = "Stage";
          l = "Toggle";
        };
      };

      sections = {
        untracked = {
          folded = false;
        };
        unstaged = {
          folded = false;
        };
        staged = {
          folded = false;
        };
        stashes = {
          folded = false;
        };
        unpulled_upstream = {
          folded = false;
        };
        unpulled_pushRemote = {
          folded = false;
        };
        unmerged_upstream = {
          folded = true;
        };
        unmerged_pushRemote = {
          folded = true;
        };
        recent = {
          folded = true;
        };
      };
    };
  };

  keymaps = [
    # Open neogit
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>Neogit<CR>";
      options.desc = "Open neogit";
    }
  ];
}
