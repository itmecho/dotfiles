vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/nvim-neotest/nvim-nio',
})

local dap, dapui = require('dap'), require('dapui')

---@diagnostic disable-next-line: missing-fields
dapui.setup({
  layouts = {
    {
      position = 'left',
      size = 60,
      elements = {
        { id = 'scopes', size = 0.7 },
      },
    },
  },
})

vim.keymap.set('n', '<leader>xb', dap.toggle_breakpoint, { desc = 'DAP Toggle breakpoint' })
vim.keymap.set('n', '<leader>xB', function()
  dap.set_breakpoint(vim.fn.input('Condition: '))
end, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>xc', dap.continue, { desc = 'DAP continue' })
vim.keymap.set('n', '<leader>xx', dap.close, { desc = 'DAP close' })
vim.keymap.set('n', '<leader>xh', dap.step_out, { desc = 'DAP step out' })
vim.keymap.set('n', '<leader>xj', dap.step_over, { desc = 'DAP step over' })
vim.keymap.set('n', '<leader>xk', dap.step_back, { desc = 'DAP step back' })
vim.keymap.set('n', '<leader>xl', dap.step_into, { desc = 'DAP step into' })
vim.keymap.set('n', '<leader>xr', dap.run_to_cursor, { desc = 'DAP run to cursor' })
vim.keymap.set('n', '<leader>xu', dapui.toggle, { desc = 'DAP toggle UI' })

-- Hook up DAP UI
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

require('dap-go').setup()
