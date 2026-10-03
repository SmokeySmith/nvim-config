-- Debugging via nvim-dap.
--
-- C/C++ use GDB's native DAP server (`gdb -i dap`, GDB 14+), so no extra
-- adapter needs installing. Build with `-g -O0` so breakpoints and locals
-- line up with the source.
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<leader>Dc", function() require("dap").continue() end, desc = "[C]ontinue / start" },
      { "<leader>Dn", function() require("dap").step_over() end, desc = "Step over ([n]ext)" },
      { "<leader>Di", function() require("dap").step_into() end, desc = "Step [i]nto" },
      { "<leader>Do", function() require("dap").step_out() end, desc = "Step [o]ut" },
      { "<leader>Db", function() require("dap").toggle_breakpoint() end, desc = "Toggle [b]reakpoint" },
      {
        "<leader>DB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional [B]reakpoint",
      },
      { "<leader>DC", function() require("dap").run_to_cursor() end, desc = "Run to [C]ursor" },
      { "<leader>Dr", function() require("dap").run_last() end, desc = "[R]un last" },
      { "<leader>Dt", function() require("dap").terminate() end, desc = "[T]erminate" },
      { "<leader>Du", function() require("dapui").toggle() end, desc = "Toggle [u]i" },
      { "<leader>De", function() require("dapui").eval() end, desc = "[E]val expression", mode = { "n", "x" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      local function pick_program()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = pick_program,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Launch with arguments",
          type = "gdb",
          request = "launch",
          program = pick_program,
          args = function()
            return vim.split(vim.fn.input("Arguments: "), " ", { trimempty = true })
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to process",
          type = "gdb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.cpp = dap.configurations.c

      -- Open the UI when a session starts and close it when it ends.
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })
    end,
  },
}
