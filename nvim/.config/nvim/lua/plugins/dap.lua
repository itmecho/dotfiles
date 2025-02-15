return {
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    keys = {
      {
        '<leader>xb',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle breakpoint',
      },
      {
        '<leader>xB',
        function()
          local condition = vim.fn.input("Condition: ")
          require('dap').set_breakpoint(condition)
        end,
        desc = 'Toggle breakpoint',
      },
      {
        '<leader>xc',
        function()
          -- require('dap.ext.vscode').load_launchjs()
          require('dap').continue()

        end,
        desc = 'Continue',
      },
      {
        '<leader>xr',
        function()
          require('dap').restart()
        end,
        desc = 'Restart',
      },
      {
        '<leader>xx',
        function()
          require('dap').close()
        end,
        desc = 'Close',
      },
      {
        '<leader>xh',
        function()
          require('dap').step_out()
        end,
        desc = 'Step out',
      },
      {
        '<leader>xj',
        function()
          require('dap').step_over()
        end,
        desc = 'Step over',
      },
      {
        '<leader>xk',
        function()
          require('dap').step_back()
        end,
        desc = 'Step back',
      },
      {
        '<leader>xl',
        function()
          print('stepping into')
          require('dap').step_into()
        end,
        desc = 'Step into',
      },
      {
        '<leader>xr',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Step into',
      },
      {
        '<leader>xs',
        function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end,
        desc = 'Toggle Floating scopes',
      }
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup({
        layouts = {
          {
            position = 'left',
            size = 60,
            elements = {
              { id = 'scopes', size = 0.7 },
              { id = 'breakpoints', size = 0.3 },
            },
          },
          {
            position = 'bottom',
            size = 10,
            elements = {
              { id = 'repl', size = 1},
            },
          }
        },
      })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
    keys = {
      {
        '<leader>xu',
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle DAP UI',
      },
    },
  },
  { 'leoluz/nvim-dap-go', config = true },
}
