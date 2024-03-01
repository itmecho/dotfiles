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
        '<leader>xc',
        function()
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
          require('dap.ext.vscode').load_launchjs('./launch.json')
        end,
        desc = 'Load launch.json from the current directory',
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
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
