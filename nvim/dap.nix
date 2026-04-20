{ pkgs, ... }:

{
  plugins.dap-go.enable = true;

  plugins.dap = {
    enable = true;

    # Note the change to 'adapters.servers' or 'adapters.executables'
    # depending on your NixVim version. To be most compatible:
    adapters = {
      executables = {
        codelldb = {
          command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
        };
        pwa-node = {
          command = "${pkgs.vscode-js-debug}/bin/js-debug-adapter";
        };
      };
    };

    configurations = {
      go = [
        {
          type = "delve";
          name = "Debug (Delve)";
          request = "launch";
          program = "\${file}";
        }
      ];
      javascript = [
        {
          type = "pwa-node";
          request = "launch";
          name = "Launch file";
          program = "\${file}";
          cwd = "\${workspaceFolder}";
        }
      ];
      typescript = [
        {
          type = "pwa-node";
          request = "launch";
          name = "Launch file";
          program = "\${file}";
          cwd = "\${workspaceFolder}";
          sourceMaps = true;
        }
      ];
      rust = [
        {
          type = "codelldb";
          name = "Debug Rust binary";
          request = "launch";
          program = "\${workspaceFolder}/target/debug/\${workspaceFolderBasename}";
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>dc";
      action = "<cmd>lua require('dap').continue()<CR>";
      options.desc = "DAP Continue";
    }
    {
      mode = "n";
      key = "<leader>db";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
      options.desc = "DAP Toggle Breakpoint";
    }
  ];
}
