{ pkgs, lib, ... }:

{
  plugins.dap = {
    enable = true;

    signs = {
      dapBreakpoint = {
        text = "●";
        texthl = "DiagnosticError";
      };
      dapBreakpointCondition = {
        text = "◆";
        texthl = "DiagnosticWarn";
      };
      dapLogPoint = {
        text = "◉";
        texthl = "DiagnosticInfo";
      };
      dapStopped = {
        text = "→";
        texthl = "DiagnosticOk";
        linehl = "Visual";
      };
      dapBreakpointRejected = {
        text = "○";
        texthl = "DiagnosticHint";
      };
    };

    adapters.servers = {
      codelldb = {
        port = "\${port}";
        executable = {
          command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
          args = [
            "--port"
            "\${port}"
          ];
        };
      };
      pwa-node = {
        host = "localhost";
        port = "\${port}";
        executable = {
          command = lib.getExe pkgs.vscode-js-debug;
          args = [ "\${port}" ];
        };
      };
    };

    configurations =
      let
        jsConfigs = [
          {
            type = "pwa-node";
            request = "launch";
            name = "Launch file";
            program = "\${file}";
            cwd = "\${workspaceFolder}";
            sourceMaps = true;
            skipFiles = [
              "<node_internals>/**"
              "**/node_modules/**"
            ];
          }
          {
            type = "pwa-node";
            request = "launch";
            name = "Launch file (tsx)";
            runtimeExecutable = "npx";
            runtimeArgs = [ "tsx" ];
            program = "\${file}";
            cwd = "\${workspaceFolder}";
            sourceMaps = true;
            skipFiles = [
              "<node_internals>/**"
              "**/node_modules/**"
            ];
          }
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach to process";
            processId.__raw = "require('dap.utils').pick_process";
            cwd = "\${workspaceFolder}";
          }
        ];
      in
      {
        javascript = jsConfigs;
        typescript = jsConfigs;
        javascriptreact = jsConfigs;
        typescriptreact = jsConfigs;

        rust = [
          {
            type = "codelldb";
            name = "Debug Rust binary";
            request = "launch";
            program.__raw = ''
              function()
                return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
              end
            '';
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
          }
        ];
        # Go: no entries here, dap-go registers the adapter and configurations.
      };
  };

  plugins.dap-go = {
    enable = true;
    settings.delve.path = lib.getExe pkgs.delve;
  };

  plugins.dap-ui.enable = true;
  plugins.dap-virtual-text.enable = true;

  # Open/close the UI automatically with debug sessions
  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
  '';

  keymaps =
    let
      kmap = key: fn: desc: {
        mode = "n";
        inherit key;
        action.__raw = "function() ${fn} end";
        options.desc = desc;
      };
    in
    [
      (kmap "<leader>dc" "require('dap').continue()" "DAP Continue / Start")
      (kmap "<leader>db" "require('dap').toggle_breakpoint()" "DAP Toggle breakpoint")
      (kmap "<leader>dB" "require('dap').set_breakpoint(vim.fn.input('Condition: '))"
        "DAP Conditional breakpoint"
      )
      (kmap "<leader>do" "require('dap').step_over()" "DAP Step over")
      (kmap "<leader>di" "require('dap').step_into()" "DAP Step into")
      (kmap "<leader>dO" "require('dap').step_out()" "DAP Step out")
      (kmap "<leader>dl" "require('dap').run_last()" "DAP Run last")
      (kmap "<leader>dt" "require('dap').terminate()" "DAP Terminate")
      (kmap "<leader>dr" "require('dap').repl.toggle()" "DAP Toggle REPL")
      (kmap "<leader>du" "require('dapui').toggle()" "DAP Toggle UI")
      (kmap "<leader>dgt" "require('dap-go').debug_test()" "DAP Go: debug test")
    ];
}
